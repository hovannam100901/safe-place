# frozen_string_literal: true

# == Schema Information
#
# Table name: rooms
#
#  id           :bigint           not null, primary key
#  name         :string(255)
#  status       :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  counselor_id :bigint           not null
#  user_id      :bigint
#
# Indexes
#
#  index_rooms_on_counselor_id  (counselor_id)
#  index_rooms_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (counselor_id => users.id)
#  fk_rails_...  (user_id => users.id)
#
class Room < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :counselor
  has_many :conversations, dependent: :destroy

  validates :name, presence: true

  paginates_per 16

  def self.ransackable_attributes(_auth_object = nil)
    %w[counselor_id created_at id name status updated_at user_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[conversations counselor user]
  end
end
