# frozen_string_literal: true

# == Schema Information
#
# Table name: courses
#
#  id              :bigint           not null, primary key
#  deleted_at      :datetime
#  description     :string(255)
#  image           :string(255)
#  instructor_name :string(255)      not null
#  name            :string(255)      not null
#  price           :decimal(10, 2)   not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  admin_id        :bigint           not null
#
# Indexes
#
#  index_courses_on_admin_id    (admin_id)
#  index_courses_on_deleted_at  (deleted_at)
#
# Foreign Keys
#
#  fk_rails_...  (admin_id => admins.id)
#
class Course < ApplicationRecord
  belongs_to :admin
  has_many :course_sessions, dependent: :destroy
  has_many :enrollments, as: :enrollmentable, dependent: :nullify
end
