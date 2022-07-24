module PlantsHelper
  def plant_img plant
    if plant.img.present?
      image_tag plant.img
    else
      image_tag "favicon.png"
    end
  end
end
