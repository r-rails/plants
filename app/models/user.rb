class User < ApplicationRecord
  before_save :downcase_username
  before_create :set_avatar

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :confirmable

  has_one_attached :avatar
  has_many :garden_plants
  has_many :plants, through: :garden_plants, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :email, presence: true, format: URI::MailTo::EMAIL_REGEXP

  default_scope { order(username: :asc) }

  private

  def downcase_username
    self.username = username.downcase
  end

  def set_avatar
    icon = Icodi.new.render
    avatar.attach(io: StringIO.new(icon), filename: "#{username}.svg", content_type: "image/svg+xml")
  end
end
