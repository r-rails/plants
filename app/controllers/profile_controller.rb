# frozen_string_literal: true

class ProfileController < ApplicationController
  def show
    @user = User.friendly.includes(:plants).find_by_slug(params[:slug])
    @plants = @user&.plants&.page(params[:page])&.per(10)
    return if @user

    flash[:error] = "User not found"
    redirect_to root_path
  end
end
