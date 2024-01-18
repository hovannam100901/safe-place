# frozen_string_literal: true

# == Schema Information
#
# Table name: podcasts
#
#  id               :bigint           not null, primary key
#  audio            :string(255)      not null
#  author_name      :string(255)
#  duration         :decimal(10, )
#  episode_number   :integer
#  image            :string(255)
#  name             :string(255)      not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  podcast_album_id :bigint           not null
#
# Indexes
#
#  index_podcasts_on_podcast_album_id  (podcast_album_id)
#
# Foreign Keys
#
#  fk_rails_...  (podcast_album_id => podcast_albums.id)
#
class Podcast < ApplicationRecord
  belongs_to :podcast_album
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :bookmarks, as: :bookmarkable, dependent: :destroy
  validates :audio, presence: true

  mount_uploader :audio, AudioUploader
  mount_uploader :image, ImageUploader

  def self.ransackable_attributes(_auth_object = nil)
    %w[audio author_name created_at duration episode_number id image name podcast_album_id
       updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[bookmarks likes podcast_album]
  end
end
