class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :garden_plants
  has_many :plants, through: :garden_plants, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :email, presence: true, format: URI::MailTo::EMAIL_REGEXP
end
