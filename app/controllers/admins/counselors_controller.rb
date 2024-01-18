# frozen_string_literal: true

module Admins
  # Class CounselorsController for Admins
  class CounselorsController < AdminsLayoutController
    before_action :set_counselor, only: %i[show edit update destroy]

    DEFAULT_PASSWORD = '123456'

    def index
      @q = Counselor.includes(:user_info).ransack(params[:q])
      @counselors = @q.result(distinct: true).order(id: :desc).page params[:page]
    end

    def new
      @counselor = Counselor.new
      @counselor.user_info = UserInfo.new
      render layout: false
    end

    def create
      @counselor = User.new(counselor_params)
      @counselor.password = DEFAULT_PASSWORD

      respond_to do |format|
        if @counselor.save
          format.turbo_stream { flash.now[:notice] = "#{@counselor.type} was successfully created!" }
        else
          format.turbo_stream { render status: :bad_request }
        end
      end
    end

    def update
      respond_to do |format|
        if @counselor.update(update_counselor_params)
          format.turbo_stream { flash.now[:notice] = "#{@counselor.type} was successfully edited!" }
        else
          format.turbo_stream do
            # flash.now[:alert] = "<ul><li>#{@counselor.errors.full_messages.join('</li><li>')}</li><ul>".html_safe
            render status: :bad_request
          end
        end
      end
    end

    def destroy
      @counselor.destroy

      respond_to do |format|
        format.html do
          redirect_to admins_counselors_url(page: params[:page]), notice: 'User was successfully destroyed.'
        end
        format.json { head :no_content }
      end
    end

    def toggle_anonymous
      @counselor = User.find_by(id: params[:id])
      @counselor.update(anonymous: params[:anonymous])
      render json: { message: "The 'Anonymous' status has been successfully updated." }
    end

    def show
      render layout: false
    end

    def edit
      render layout: false
    end

    private

    def set_counselor
      @counselor = User.find_by(id: params[:id])
    end

    def update_counselor_params
      params.require(:counselor).permit(:anonymous, :password, :phone_number, :status, :type, :user_name,
                                        user_info_attributes: %i[id address date_of_birth gender profile_name])
    end

    def counselor_params
      params.require(:counselor).permit(:email, :anonymous, :password, :phone_number, :status, :type, :user_name,
                                        user_info_attributes: %i[address date_of_birth gender profile_name])
    end
  end
end
