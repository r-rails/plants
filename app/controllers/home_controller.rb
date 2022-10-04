# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @q = Plant.ransack(params[:q])
    @most_recent_plants = Plant.with_attached_img.order(created_at: :desc).limit(6)
  end

  def plants
  end

  def people
    @users = User.with_attached_avatar.order(username: :asc)
  end

  def top_growers
    @growers = User.with_attached_avatar.where('plants_count > ?', 0).order(plants_count: :desc)
  end
end
