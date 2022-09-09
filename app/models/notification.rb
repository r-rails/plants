class Notification < ApplicationRecord
  include Noticed::Model
  belongs_to :recipient, polymorphic: true

  scope :is_deleted, -> { where.not(deleted_at: nil) }

  default_scope { where(deleted_at: nil) }

  after_create_commit :update_counter, :broadcast_to_recipient
  after_update_commit :update_counter, :update_pluralization

  private

  def broadcast_to_recipient
    broadcast_append_later_to(
      recipient,
      :notifications,
      target: "notifications-list",
      partial: "notifications/notification",
      locals: {
        notification: self
      }
    )
  end

  def update_counter
    broadcast_update_to(
      recipient,
      :counter,
      target: "counter",
      html: (recipient.notifications.unread.count >= 9 ? "9+" : recipient.notifications.unread.count).to_s
    )
  end

  def update_pluralization
    broadcast_update_to(
      recipient,
      :notification_pluralization,
      target: "notification_pluralization",
      html: (recipient.notifications.unread.count == 1 ? "Notification" : "Notifications")
    )
  end

  
end
