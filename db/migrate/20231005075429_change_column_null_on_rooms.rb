# frozen_string_literal: true

# Change column user_id to null: true
class ChangeColumnNullOnRooms < ActiveRecord::Migration[7.0]
  def change
    change_column_null :rooms, :user_id, true
  end
end
