# frozen_string_literal: true

module Admins
  # PodcastAlbumsController
  class PodcastAlbumsController < AdminsLayoutController
    before_action :set_podcast_album, only: %i[show edit update destroy]
    before_action :set_default_result
    # GET /podcast_albums or /podcast_albums.json
    def index
      @q = PodcastAlbum.ransack(params[:q])
      @podcast_albums = @q.result(distinct: true).page(params[:page])
      @users = User.all
      @podcast_album = PodcastAlbum.new
    end

    # GET /podcast_albums/1 or /podcast_albums/1.json
    def show
      @podcast = Podcast.where('podcast_album_id = ?', params[:id])
    end

    # GET /podcast_albums/new
    def new
      @podcast_album = PodcastAlbum.new
      @podcast_album.image = params[:file]
      respond_to do |format|
        format.html
        format.js
        format.json { render json: @podcast_album }
      end
    end

    # GET /podcast_albums/1/edit
    def edit; end

    # POST /podcast_albums or /podcast_albums.json
    def create
      @podcast_album = PodcastAlbum.new(podcast_album_params)
      if @podcast_album.save
        flash[:message] = 'Create successful'
        @result = { success: true, message: 'Create successful' }
      else
        flash[:message] = @podcast_album.errors.full_messages
        @result = { success: false, message: 'Create failed' }
      end
    end

    # PATCH/PUT /podcast_albums/1 or /podcast_albums/1.json
    def update
      if @podcast_album.update(podcast_album_params)
        flash[:message] = 'Update successful'
        @result = { success: true, message: 'Update successful' }
      else
        # binding.pry
        flash[:message] = @podcast_album.errors.full_messages
        @result = { success: false, message: 'Create failed' }
      end
    end

    # DELETE /podcast_albums/1 or /podcast_albums/1.json
    def destroy
      # @podcast_album = PodcastAlbum.find(params[:id])
      @podcast_album.destroy
      redirect_to admins_podcast_albums_url
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_podcast_album
      @podcast_album = PodcastAlbum.find_by(id: params[:id])
    end

    # Only allow a list of trusted parameters through.
    def podcast_album_params
      params.require(:podcast_album).permit(:name, :user_id, :image)
    end

    def set_default_result
      @result = { success: false }
    end
  end
end
