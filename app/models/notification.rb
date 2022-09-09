class Notification < ApplicationRecord
  include Noticed::Model
  belongs_to :recipient, polymorphic: true

  scope :not_deleted, -> { where(deleted_at: nil) }

  default_scope { where("deleted_at > ?", 20.seconds.ago).or(where(deleted_at: nil)) }

  after_create_commit :update_counter, :broadcast_to_recipient

  def update_counter
    broadcast_update_to(
      recipient,
      :counter,
      target: "counter",
      html: "#{recipient.notifications.not_deleted.unread.count >= 9 ? "9+" : recipient.notifications.not_deleted.unread.count }"
    )
  end

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
end
