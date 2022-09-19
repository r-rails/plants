# frozen_string_literal: true

class User < ApplicationRecord
  before_create :set_avatar

  before_update do |record|
    if record.changed.include?('slug')
      errors.add(:immutable_field_error, 'You are not allowed to change this attribute' )
      raise ActiveRecord::RecordInvalid.new(record)
    end
  end

  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,:confirmable,
    :omniauthable, omniauth_providers: [:google_oauth2]

  has_one_attached :avatar, dependent: :destroy
  has_many :garden_plants
  has_many :plants, through: :garden_plants, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, as: :recipient, dependent: :destroy
  validates :email, presence: true, format: URI::MailTo::EMAIL_REGEXP
  validates :username, presence: true

  extend FriendlyId
  friendly_id :slugged_usernames, use: :slugged


  private

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initiailize do |user|
      user.email = auth.info.email
      user.username = user.email.split('@').first
      user.password = Devise.friendly_token[0, 20]
      user.skip_confirmation!
      user.save!
    end
  end

  def set_avatar
    icon = Icodi.new.render
    avatar.attach(io: StringIO.new(icon), filename: "#{username}.svg", content_type: "image/svg+xml")
  end

  def slugged_usernames
    [:username, %i[username created_at]]
  end
end
