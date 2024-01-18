# frozen_string_literal: true

# class CreateUserInfos
class CreateUserInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :user_infos do |t|
      t.string :address
      t.date :date_of_birth
      t.string :profile_name
      t.string :gender
      t.references :user, null: false, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :user_infos, :deleted_at
  end
end
