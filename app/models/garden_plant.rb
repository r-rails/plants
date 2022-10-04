# frozen_string_literal: true

class GardenPlant < ApplicationRecord
  belongs_to :user, counter_cache: :plants_count
  belongs_to :plant, counter_cache: :users_count

  validates_uniqueness_of :user_id, scope: :plant_id, message: "can only have one type plant in your garden"
end
