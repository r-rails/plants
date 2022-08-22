# frozen_string_literal: true

module PlantsHelper
  def plant_img(plant)
    if plant.img.present?
      image_tag plant.img.variant(
        resize_to_fill: [400, 400],
        convert: "jpg",
        saver: {quality: 50}
      )
    else
      image_tag "favicon.png"
    end
  end

  def ppl_have
    render_haml <<-HAML
      .text-2xl.py-1.font-semibold.rounded.bg-green-200
        %span= @plant.users.count
    HAML
  end
end
