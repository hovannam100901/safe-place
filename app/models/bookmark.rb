# frozen_string_literal: true

# == Schema Information
#
# Table name: bookmarks
#
#  id                :bigint           not null, primary key
#  anonymous         :boolean          default(FALSE)
#  bookmarkable_type :string(255)      not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  bookmarkable_id   :bigint           not null
#  user_id           :bigint           not null
#
# Indexes
#
#  index_bookmarks_on_bookmarkable  (bookmarkable_type,bookmarkable_id)
#  index_bookmarks_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :bookmarkable, polymorphic: true

  # validates :user_id,
  #           uniqueness: { scope: %i[bookmarkable_id bookmarkable_type],
  #                         message: 'Already Exist!' }
end
