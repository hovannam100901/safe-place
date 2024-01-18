# frozen_string_literal: true

# class CreateBookmarks
class CreateBookmarks < ActiveRecord::Migration[7.0]
  def change
    create_table :bookmarks do |t|
      t.boolean :bookmark, default: false
      t.boolean :anonymous, default: false
      t.references :user, null: false, foreign_key: true
      t.references :bookmarkable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
