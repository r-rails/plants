# frozen_string_literal: true

class GardenPlantController < ApplicationController
  def create
    current_user.garden_plants.create(plant_id: params[:plant_id])
    flash[:notice] = "Plant added to garden successfully"
    redirect_to plant_path(params[:plant_id])
  end

  def destroy
    GardenPlant.find_by(plant_id: params[:plant_id], user_id: current_user.id).destroy
    flash[:notice] = "Plant removed from garden"
    redirect_to plant_path(params[:plant_id])
  end
end
