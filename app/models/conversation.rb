# frozen_string_literal: true

# == Schema Information
#
# Table name: conversations
#
#  id                    :bigint           not null, primary key
#  conversationable_type :string(255)      not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  conversationable_id   :bigint           not null
#  room_id               :bigint           not null
#
# Indexes
#
#  index_conversations_on_conversationable  (conversationable_type,conversationable_id)
#  index_conversations_on_room_id           (room_id)
#
# Foreign Keys
#
#  fk_rails_...  (room_id => rooms.id)
#
class Conversation < ApplicationRecord
  belongs_to :room
  belongs_to :conversationable, polymorphic: true
  has_rich_text :content

  validates :content, presence: { message: "Content can't be null" }
end
