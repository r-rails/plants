# frozen_string_literal: true

# This is a Comment class that users make on the Plants they are viewing.
class Comment < ApplicationRecord
  has_noticed_notifications

  belongs_to :user, counter_cache: true
  belongs_to :commentable, polymorphic: true, inverse_of: :comments

  validates :body, presence: true

  after_create_commit :notify_user

  def find_top_parent
    return commentable unless commentable.is_a?(comment)

    commentable.find_top_parent
  end

  def notify_user
    notify_group = User.joins(:garden_plants).where(garden_plants: {plant_id: commentable_id}).all.excluding(user)
    CommentNotification.with(comment: self).deliver_later(notify_group)
  end
end
