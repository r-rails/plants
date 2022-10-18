# frozen_string_literal: true

module PlantsHelper
  
  def plant_img_index(plant)
    if plant.img.present?
      image_tag plant.img.variant(
        resize_to_fill: [350, 250],
        convert: "webp",
        saver: {quality: 100}
      )
    else
      image_tag "favicon.png", size: "250"
    end
  end
end
