# frozen_string_literal: true

# Add image column to podcast albums
class AddImageToPodcastAlbums < ActiveRecord::Migration[7.0]
  def change
    add_column :podcast_albums, :image, :string
  end
end
