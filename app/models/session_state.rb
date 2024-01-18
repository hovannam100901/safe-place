# frozen_string_literal: true

# == Schema Information
#
# Table name: session_states
#
#  id                :bigint           not null, primary key
#  complete          :boolean          default(FALSE)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  course_session_id :bigint           not null
#  user_id           :bigint           not null
#
# Indexes
#
#  index_session_states_on_course_session_id  (course_session_id)
#  index_session_states_on_user_id            (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_session_id => course_sessions.id)
#  fk_rails_...  (user_id => users.id)
#
class SessionState < ApplicationRecord
  belongs_to :course_session
  belongs_to :user
end
