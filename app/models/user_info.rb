# frozen_string_literal: true

# == Schema Information
#
# Table name: user_infos
#
#  id            :bigint           not null, primary key
#  address       :string(255)
#  avatar        :string(255)
#  date_of_birth :date
#  deleted_at    :datetime
#  gender        :string(255)
#  profile_name  :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_user_infos_on_deleted_at  (deleted_at)
#  index_user_infos_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class UserInfo < ApplicationRecord
  belongs_to :user

  acts_as_paranoid

  mount_uploader :avatar, ImageUploader

  enum gender: { male: 'male', female: 'female', non_binary: 'non_binary', other: 'other' }

  def self.ransackable_attributes(_auth_object = nil)
    %w[address created_at date_of_birth deleted_at gender id profile_name updated_at user_id]
  end
end
