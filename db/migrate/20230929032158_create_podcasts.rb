# frozen_string_literal: true

# class CreatePodcasts
class CreatePodcasts < ActiveRecord::Migration[7.0]
  def change
    create_table :podcasts do |t|
      t.string :name, null: false
      t.references :podcast_album, null: false, foreign_key: true
      t.string :author_name
      t.string :audio, null: false
      t.string :image
      t.integer :episode_number

      t.timestamps
    end
  end
end
