# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  bio                    :string
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  full_name              :string           default(""), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locked_at              :datetime
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  unconfirmed_email      :string
#  unlock_token           :string
#  username               :string           default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable, :omniauthable

  has_one_attached :avatar
  has_one_attached :avatar_background

  before_save :strip_and_downcase_fields

  # Validations
  USERNAME_REGEX = /\w+/
  RESERVED_USERNAMES = Rails.application.routes.routes.map do |route|
    route.path.spec.to_s[%r{(?<=\A/)\w+}]
  end.compact.uniq.freeze
  FULL_NAME_REGEX = /\A[^0-9`!@#$%\^&*+_=]+\z/

  validates :bio, length: { maximum: 140 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Email invalid" },
                    uniqueness: { case_sensitive: false },
                    length: { minimum: 4, maximum: 254 }
  validates :full_name, presence: true, format: { with: FULL_NAME_REGEX, message: "Name invalid" }, length: 5..25
  validates :username, presence: true, format: { with: USERNAME_REGEX, message: "Username invalid" }, length: 5..25,
                       uniqueness: { case_sensitive: false }, exclusion: { in: RESERVED_USERNAMES }

  def avatar_as_thumbnail
    avatar.variant(resize_to_limit: [96, 96]).processed
  end

  def avatar_background_as_thumbnail
    avatar_background.variant(resize_to_limit: [500, 500]).processed
  end

  def initialize(args = {})
    args[:email].strip!.downcase! if args[:email]
    args[:username].strip!.downcase! if args[:username]
    args[:full_name].strip! if args[:full_name]
    args[:bio].strip! if args[:bio]
    super
  end

  def strip_and_downcase_fields
    (email.strip! && email.downcase!) unless email.blank?
    (username.strip! && username.downcase!) unless username.blank?
    full_name.strip! unless full_name.blank?
    bio.strip! unless bio.blank?
  end

  # Overriding to_param so the username (instead of id) is used for route path and URL helpers:
  def to_param
    username
  end
end
