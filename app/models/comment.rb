class Comment < ApplicationRecord
  has_rich_text :body
  belongs_to :user
  belongs_to :plant

  validates_presence_of :body
end
