class NotificationsController < ApplicationController
  def index
    @notifications = Notification.where(recipient: current_user)
  end

  def set_to_read
    @notification = Notification.find_by_id(params[:id])
    @notification.mark_as_read!
    redirect_back_or_to current_user
  end

  def set_to_unread
    @notification = Notification.find_by_id(params[:id])
    @notification.mark_as_unread!
    redirect_back_or_to current_user
  end

  def destroy
    @notification = Notification.find_by_id(params[:id])
    @notification.mark_as_read!
    @notification.destroy
    
    redirect_back_or_to current_user
  end
end
