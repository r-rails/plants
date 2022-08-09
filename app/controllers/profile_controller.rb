# frozen_string_literal: true

class ProfileController < ApplicationController
  def show
    @user = User.friendly.includes(:plants).find_by_slug(params[:slug])
    @user_plants = @user&.plants&.with_attached_img.page(params[:page]).per(20)
    return if @user

    flash[:error] = "User not found"
    redirect_to root_path
  end
end
