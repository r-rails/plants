# frozen_string_literal: true

module PlantsHelper
  def plant_img(plant)
    if plant.img.present?
      image_tag plant.img.variant(
        resize_to_fill: [400, 400],
        convert: "webp",
        saver: {quality: 100}
      )
    else
      image_tag "favicon.png"
    end
  end

  def plant_img_index(plant)
    if plant.img.present?
      image_tag plant.img.variant(
        resize_to_fill: [150, 150],
        convert: "webp",
        saver: {quality: 100}
      )
    else
      image_tag "favicon.png", size: "150"
    end
  end

  def ppl_have
    render_haml <<-HAML
      .text-2xl.py-1.font-semibold.rounded.bg-green-200
        %span= @plant.users.count
    HAML
  end
end
