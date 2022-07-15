class Plant < ApplicationRecord
  validates_presence_of :name

  has_one_attached :img
  has_many :garden_plants
  has_many :users, through: :garden_plants, dependent: :destroy
  has_many :comments, dependent: :destroy

end
