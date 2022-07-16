
class ProfileController < ApplicationController
  
  def show
    @user = User.includes(:plants).where(id: params[:id]).first

    @plants = @user&.plants.page(params[:page]).per(10)
    if !@user
      flash[:error] = "User not found"
      redirect_to root_path
    end
  end

end