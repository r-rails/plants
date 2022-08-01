# frozen_string_literal: true

class GardenPlant < ApplicationRecord
  belongs_to :user
  belongs_to :plant

  validates_uniqueness_of :user_id, scope: :plant_id, message: "can only have one type plant in your garden"
end
