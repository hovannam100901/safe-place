# frozen_string_literal: true

module Admins
  # PodcastsController
  class PodcastsController < AdminsLayoutController
    before_action :set_podcast, only: %i[show edit update destroy]

    # GET /podcasts or /podcasts.json
    def index
      @podcasts = Podcast.all
      @podcast = Podcast.new
    end

    # GET /podcasts/1 or /podcasts/1.json
    def show
      render json: @podcast
    end

    # GET /podcasts/new
    def new
      @podcast = Podcast.new
    end

    # GET /podcasts/1/edit
    def edit; end

    # POST /podcasts or /podcasts.json
    def create
      @podcast = Podcast.new(create_podcast_params)
      respond_to do |format|
        if @podcast.save
          format.json { render json: @podcast, status: :created }
        else
          format.json { render json: @podcast.errors.full_messages, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /podcasts/1 or /podcasts/1.json
    def update
      respond_to do |format|
        if @podcast.update(podcast_params)
          format.json { render json: @podcast, status: :ok }
        else
          format.json { render json: @podcast.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /podcasts/1 or /podcasts/1.json
    def destroy
      @podcast.destroy

      respond_to do |format|
        format.html { redirect_to podcasts_url, notice: 'Podcast was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_podcast
      @podcast = Podcast.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def podcast_params
      params.permit(:name, :id)
    end

    def create_podcast_params
      params.permit(:name, :author_name, :episode_number, :image, :audio, :podcast_album_id)
    end
  end
end
