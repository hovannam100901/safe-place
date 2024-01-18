# frozen_string_literal: true

# == Schema Information
#
# Table name: podcast_albums
#
#  id         :bigint           not null, primary key
#  image      :string(255)
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_podcast_albums_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class PodcastAlbum < ApplicationRecord
  belongs_to :user
  has_many :podcasts, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :bookmarks, as: :bookmarkable, dependent: :destroy
  max_paginates_per 10
  mount_uploader :image, ImageUploader
  validates :name, :user_id, presence: { message: 'not null' }
  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id image name updated_at user_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[podcasts user]
  end

  def total_duration
    podcasts.sum(:duration)
  end
end
