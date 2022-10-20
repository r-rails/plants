# frozen_string_literal: true

module PlantsHelper
  def plant_img_index(plant)
    if plant.img.present?
      image_tag plant.img, size: "250"
    else
      image_tag "favicon.png", size: "250"
    end
  end
end
