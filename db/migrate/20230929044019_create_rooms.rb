# frozen_string_literal: true

# class CreateRooms
class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.references :user, foreign_key: { to_table: :users }, null: false
      t.references :counselor, foreign_key: { to_table: :users }, null: false

      t.timestamps
    end
  end
end
