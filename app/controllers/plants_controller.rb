class PlantsController < ApplicationController
  def index
    @plants = Plant.all
  end
  
  def show
    @plant = Plant.find(params[:id])
  end

  def new
    @plant = Plant.new
  end

  def create
    @plant = Plant.new(plant_params)

    if @plant.save
      redirect_to @plant
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def plant_params
      params.require(:plant).permit(:name, :description, :img, :climate, :ideallight,
      :watering, :category, :latin)
    end
end
