# frozen_string_literal: true

# class RemoveBookmarkFromBookmarks
class RemoveBookmarkFromBookmarks < ActiveRecord::Migration[7.0]
  def up
    remove_column :bookmarks, :bookmark
  end

  def down
    add_column :bookmarks, :bookmark, :boolean
  end
end
