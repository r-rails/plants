class Notification < ApplicationRecord
  include Noticed::Model
  belongs_to :recipient, polymorphic: true

  scope :not_deleted, -> { where(deleted_at: nil) }

  default_scope { where("deleted_at > ?", 20.seconds.ago).or(where(deleted_at: nil)) }
end
