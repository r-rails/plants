# frozen_string_literal: true

class PlantsController < ApplicationController

  def index
    @q = Plant.ransack(params[:q])
    @plants = @q.result.order(:latin).page(params[:page]).per(12)
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

  def category_hovercard
    @category = Plant.friendly.find(params[:plant_id])&.category

    render partial: "plants/category_hovercard", layout: false
  end

  def most_recent_plants 
    @most_recent_plants = Plant.order(created_at: :desc).limit(6) 
  end

  def top_ten_plants
    @top_ten_plants = Plant.joins(:users)
      .group(:id)
      .order("COUNT(users.id) DESC")
      .limit(10) || Plant.all.sample(10)
  end

  private

  def plant_params
    params.require(:plant).permit(:name, :description, :img, :climate, :ideallight,
      :watering, :category, :latin)
  end

end
