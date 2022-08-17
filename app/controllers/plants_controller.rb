# frozen_string_literal: true

class PlantsController < ApplicationController
  def index
    @q = Plant.ransack(params[:q])
    @plants = @q.result.order(:latin).page params[:page]
  end

  def show
    @q = Plant.ransack(params[:q])
    @plant = Plant.friendly.find(params[:id])
    @commentable = @plant
    @comment = Comment.new
    @comments = @plant.comments
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

  def update
    @plant = Plant.friendly.find(params[:id])
    @plant.img.attach(params[:img])
    if @plant.img.attached?
      #success
      redirect_to @plant
    else
      #failure
    end
    redirect_to plants_path
  end

  def category_hovercard
    @category = Plant.friendly.find(params[:plant_id])&.category

    render partial: "plants/category_hovercard", layout: false
  end

  def gardenplant_hovercard
    @plant = Plant.friendly.find(params[:plant_id])

    render partial: "plants/gardenplant_hovercard", layout: false
  end

  private

  def plant_params
    params.require(:plant).permit(:name, :description, :img, :climate, :ideallight,
      :watering, :category, :latin)
  end
end
