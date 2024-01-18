# frozen_string_literal: true

# class CreateConfessions
class CreateConfessions < ActiveRecord::Migration[7.0]
  def change
    create_table :confessions do |t|
      # content:rich_text
      t.text :tag
      t.boolean :anonymous, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
