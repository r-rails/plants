class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :plant

  validates :body, length: { minimum: 10 }
end
