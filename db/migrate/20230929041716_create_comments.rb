# frozen_string_literal: true

# class CreateComments
class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      # content: rich_text
      t.boolean :anonymous, default: false
      t.references :user, null: false, foreign_key: true
      t.references :commentable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
