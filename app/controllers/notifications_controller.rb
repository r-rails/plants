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

  def set_to_deleted
    @notification = Notification.find_by_id(params[:id])
    @notification.deleted_at = Time.now

    if @notification.save
      redirect_back_or_to current_user
    end
  end

  def undelete_notification
    @notification = Notification.find_by_id(params[:id])
    @notification.deleted_at = nil if @notification.deleted_at > 15.seconds.ago

    if @notification.save
      redirect_back_or_to current_user
    end
  end
end
