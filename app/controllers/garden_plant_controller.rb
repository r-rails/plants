# frozen_string_literal: true

class GardenPlantController < ApplicationController
  def create
    if current_user.garden_plants.create(plant_id: params[:plant_id])
      flash[:notice] = "Plant added to garden successfully"
    else
      flash[:error] = "Plant not added to garden, you can only add a plant once"
    end
    redirect_to plant_path(params[:plant_id])
  end

  def destroy
    if current_user.garden_plants.find_by(plant_id: params[:plant_id])&.destroy
      flash[:success] = "Plant removed from garden"
    else
      flash[:error] = "Unable to remove plant from garden"
    end
    redirect_to plant_path(params[:plant_id])
  end
end
