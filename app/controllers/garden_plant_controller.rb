# frozen_string_literal: true

class GardenPlantController < ApplicationController
  def create
    @garden_plant = GardenPlant.new(plant_id: params[:plant_id])
    @garden_plant.user_id = current_user.id
    if @garden_plant.save
      flash[:notice] = 'Plant added to garden successfully'
    else
      flash[:error] = 'Plant not added to garden, you can only add a plant once'
    end
    redirect_to plant_path(params[:plant_id])
  end

  def destroy
    garden_plant = GardenPlant.find_by(plant_id: params[:plant_id], user_id: current_user.id)
    if garden_plant&.destroy
      garden_plant.destroy
      flash[:error] = 'Plant removed from garden'
    else
      flash[:error] = 'Unable to remove plant from garden'
    end
    redirect_to plant_path(params[:plant_id])
  end
end
