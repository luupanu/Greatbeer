class Style < ApplicationRecord
  include RatingAverage
  include RatingBest

  has_many :beers
  has_many :ratings, through: :beers

  validates :name, presence: true
  validates :description, presence: true
end
