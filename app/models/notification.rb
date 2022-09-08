class Notification < ApplicationRecord
  include Noticed::Model
  belongs_to :recipient, polymorphic: true

  scope :not_deleted, -> { where(deleted_at: nil) }

  default_scope { where("deleted_at > ?", 20.seconds.ago).or(where(deleted_at: nil)) }

  after_create_commit :broadcast_to_recipient

  def broadcast_to_recipient
    broadcast_append_later_to(
      recipient,
      :notifications,
      target: 'notifications-list',
      partial: 'notifications/notification',
      locals: {
        notification: self
      }
    )
  end
end
