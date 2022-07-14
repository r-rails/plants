class GardenPlantController < ApplicationController
  
  def create
    garden_plant = GardenPlant.new(plant_id: params[:plant_id])
    garden_plant.user_id = current_user.id
    if garden_plant.save
      redirect_to plant_path(params[:plant_id])
    else
      render :new, status: :unprocessable_entity
    end
  end
  
end