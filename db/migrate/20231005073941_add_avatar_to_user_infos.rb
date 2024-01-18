# frozen_string_literal: true

# Add avatar column to user infos
class AddAvatarToUserInfos < ActiveRecord::Migration[7.0]
  def change
    add_column :user_infos, :avatar, :string
  end
end
