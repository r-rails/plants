class Plant < ApplicationRecord
  has_one_attached :img
  has_many :garden_plants
  has_many :users, through: :garden_plants, dependent: :destroy

end
