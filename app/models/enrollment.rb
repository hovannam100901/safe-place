# frozen_string_literal: true

# == Schema Information
#
# Table name: enrollments
#
#  id                  :bigint           not null, primary key
#  deleted_at          :datetime
#  enrollmentable_type :string(255)      not null
#  price               :decimal(10, 2)   not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  enrollmentable_id   :bigint           not null
#  payment_id          :bigint           not null
#  user_id             :bigint           not null
#
# Indexes
#
#  index_enrollments_on_deleted_at      (deleted_at)
#  index_enrollments_on_enrollmentable  (enrollmentable_type,enrollmentable_id)
#  index_enrollments_on_payment_id      (payment_id)
#  index_enrollments_on_user_id         (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (payment_id => payments.id)
#  fk_rails_...  (user_id => users.id)
#
class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :enrollmentable, polymorphic: true
  belongs_to :payment
end
