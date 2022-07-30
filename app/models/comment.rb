class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true, inverse_of: :comments

  validates :body, presence: true

  def find_top_parent
    return commentable unless commentable.is_a?(comment)
    commentable.find_top_parent
  end
end
