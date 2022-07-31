class Plant < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  def slug_candidates
    [:name, [:name, :latin]]
  end

  validates_presence_of :name

  has_one_attached :img
  has_many :garden_plants
  has_many :users, through: :garden_plants, dependent: :destroy
  has_many :comments, -> { order(created_at: :asc) }, as: :commentable, dependent: :destroy, inverse_of: :commentable
end
