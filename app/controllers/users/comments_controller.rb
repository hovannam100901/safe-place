# frozen_string_literal: true

module Users
  # class Comments Controller
  class CommentsController < UsersLayoutController
    before_action :set_commentable
    before_action :set_channel_and_target, only: %i[create]
    before_action :set_comments, only: %i[index]
    # before_action :set_comment

    def index
      respond_to do |format|
        format.html
        format.turbo_stream
      end
    end

    def new
      @comment = @commentable.comments.new
    end

    def create
      @comment = @commentable.comments.new(comment_params)
      @comment.user_id = current_user.id
      if @comment.save
        respond_to do |format|
          format.turbo_stream { flash.now[:notice] = 'Comment was successfully created.' }
          format.json { render :show, status: :created, location: @comment }
        end
        Turbo::StreamsChannel
          .broadcast_prepend_later_to(@channel,
                                      target: @target,
                                      partial: 'users/comments/comment',
                                      locals: { user: current_user, comment: @comment })
      else
        # handle_failed_create_comment
      end
    end

    private

    def set_comments
      @comments = @commentable.comments.includes(:rich_text_comment,
                                                 :user).order(created_at: :desc).page(params[:page]).per(3)
      @current_page = @comments.current_page
      @total_pages = @comments.total_pages
      @has_next_page = @current_page < @total_pages
    end

    def set_comment
      @comment = @commentable.comments.find_by(params[:id])
      return unless @comment.nil?

      respond_to do |format|
        format.html { redirect_to root_path, alert: 'Comment not found.' }
        format.json { head :no_content }
      end
    end

    def comment_params
      params.require(:comment).permit(:comment, :anonymous, :user_id)
    end

    def set_channel_and_target
      @channel = "#{helpers.dom_id(@commentable)}_comments_channel"
      @target = "#{helpers.dom_id(@commentable)}_comments_body"
    end
  end
end
