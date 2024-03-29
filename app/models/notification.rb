class Notification < ApplicationRecord
  include Noticed::Model
  belongs_to :recipient, polymorphic: true

  default_scope { where(deleted_at: nil) }

  scope :unread, -> { where(read_at: nil) }

  after_create_commit :update_counter, :broadcast_to_recipient
  after_destroy_commit :update_on_delete
  after_update_commit :update_on_change

  def comment_id
    self[:params][:comment].id
  end

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

  def update_on_delete
    broadcast_update_to(
      recipient,
      :counter,
      target: "counter",
      html: (recipient.notifications.unread.count >= 9 ? "9+" : recipient.notifications.unread.count).to_s
    )
  end

  def update_on_change
    broadcast_update_to(
      recipient,
      :counter,
      target: "counter",
      html: (recipient.notifications.unread.count >= 9 ? "9+" : recipient.notifications.unread.count).to_s
    )
  end
end
