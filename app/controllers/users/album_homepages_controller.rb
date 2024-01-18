# frozen_string_literal: true

module Users
  # class AlbumHomePagesController
  class AlbumHomepagesController < UsersLayoutController
    def index
      if params[:q]
        matcher = matcher_from_params(params[:path])
        @q = PodcastAlbum.ransack(matcher => params[:q])
        @albums = @q.result.includes(:user)
      else
        load_default_albums
      end
    end

    def show
      @album = PodcastAlbum.find_by(id: params[:id])
      @podcasts = @album.podcasts.order(:episode_number)
      render layout: false
    end

    def all_album
      @albums = PodcastAlbum.all
    end

    private

    def matcher_from_params(path)
      hash_matchers = { album: :user_user_name_or_name_cont, podcast: :podcasts_author_name_or_podcasts_name_cont }
      query_params = URI.parse(path).query
      params = URI.decode_www_form(query_params).to_h
      key = params['search'].to_sym
      hash_matchers[key]
    end

    def load_default_albums
      @albums = PodcastAlbum.joins(:podcasts).distinct.limit(6)
      @recent_albums = PodcastAlbum.joins(:podcasts).distinct.order(created_at: :desc).limit(6)
    end
  end
end
