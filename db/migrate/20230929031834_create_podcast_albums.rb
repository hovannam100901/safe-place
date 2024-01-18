# frozen_string_literal: true

# class CreatePodcastAlbums
class CreatePodcastAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :podcast_albums do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
