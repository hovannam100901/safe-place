# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  anonymous              :boolean          default(FALSE)
#  confirmation_sent_at   :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string(255)
#  deleted_at             :datetime
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  failed_attempts        :integer          default(0), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string(255)
#  locked_at              :datetime
#  phone_number           :string(255)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  sign_in_count          :integer          default(0), not null
#  status                 :string(255)      default("available")
#  type                   :string(255)      default("User")
#  unconfirmed_email      :string(255)
#  unlock_token           :string(255)
#  user_name              :string(255)      not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_deleted_at            (deleted_at)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#  index_users_on_user_name             (user_name) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :timeoutable, :trackable, :confirmable

  has_many :conversations, as: :conversationable, dependent: :nullify
  has_many :bookmarks, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :confessions, dependent: :destroy
  has_many :enrollments, dependent: :nullify
  has_many :podcast_albums, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :schedules, dependent: :nullify
  has_many :session_states, dependent: :destroy
  has_one :user_info, dependent: :destroy
  validates :user_name, presence: { message: "can't be null" }
  validates :user_name, uniqueness: { message: 'has already taken' }
  validates :phone_number, format: { with: /(0|\+[0-9]+)[0-9]{5,}/, message: 'invalid phone number' },
                           allow_blank: true

  enum status: { available: 'available', unavailable: 'unavailable', await: 'await' }

  paginates_per 10

  acts_as_paranoid

  accepts_nested_attributes_for :user_info, allow_destroy: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[anonymous confirmation_sent_at confirmation_token confirmed_at created_at current_sign_in_at
       current_sign_in_ip deleted_at email encrypted_password failed_attempts id last_sign_in_at
       last_sign_in_ip locked_at phone_number remember_created_at reset_password_sent_at reset_password_token
       sign_in_count status type unconfirmed_email unlock_token updated_at user_name]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[bookmarks comments confessions conversations enrollments likes podcast_albums rooms
       schedules session_states user_info]
  end
end
