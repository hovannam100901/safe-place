# frozen_string_literal: true

# == Schema Information
#
# Table name: confessions
#
#  id         :bigint           not null, primary key
#  anonymous  :boolean          default(FALSE)
#  tag        :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_confessions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Confession < ApplicationRecord
  belongs_to :user
  has_rich_text :content
  has_many :bookmarks, as: :bookmarkable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :content, presence: true

  serialize :tag, Array

  def self.ransackable_attributes(_auth_object = nil)
    %w[id tags]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['user']
  end

  ransacker :tags do |parent|
    Arel.sql("CONCAT('%', #{parent.table_name}.tag, '%')")
  end
end
