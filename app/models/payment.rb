# frozen_string_literal: true

# == Schema Information
#
# Table name: payments
#
#  id         :bigint           not null, primary key
#  amount     :decimal(10, 2)   not null
#  deleted_at :datetime
#  status     :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_payments_on_deleted_at  (deleted_at)
#
class Payment < ApplicationRecord
  has_many :enrollments, dependent: :nullify
end
