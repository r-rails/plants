# frozen_string_literal: true

class PlantsController < ApplicationController
  def index
    @q = Plant.with_attached_img.ransack(params[:q])
    @plants = @q.result.order(:latin).page(params[:page]).per(12)
  end

  def show
    @q = Plant.ransack(params[:q])
    @plant = Plant.friendly.find(params[:id])
    @commentable = @plant
    @comment = Comment.new
    @comments = @plant.comments
    comment_ids = @comments.ids

    # Marking user comment notifications for this plant as read!
    if current_user
      Notification.unread.where(recipient_id: current_user.id)
        .filter { |notification| comment_ids.include?(notification.comment_id) }
        .map(&:mark_as_read!)
    end
  end

  # As of this version, a user is not allowed to create a plant object from the frontend.

  # def new; end

  # def create
  #   @plant = Plant.new(plant_params)

  #   if @plant.save
  #     redirect_to @plant
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end

  def category_hovercard
    @category = Plant.friendly.find(params[:plant_id])&.category

    render partial: "plants/category_hovercard", layout: false
  end

  def most_recent_plants
    @most_recent_plants = Plant.with_attached_img.order(created_at: :desc).limit(6)
  end

  def plants_category
    @categories = Plant.pluck(:category).uniq.sort
    @q = Plant.ransack(params[:q])
  end

  def top_ten_plants
    @top_ten_plants = Plant.with_attached_img.order(users_count: :desc)
      .limit(10) || Plant.all.sample(10)
  end

  private

  # def plant_params
  #   params.require(:plant).permit(:name, :description, :img, :climate, :ideallight,
  #     :watering, :category, :latin)
  # end
end
