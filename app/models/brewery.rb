class Brewery < ApplicationRecord
  include RatingAverage
  include RatingBest

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true

  validates :year, numericality: {
    greater_than_or_equal_to: 1040,
    less_than_or_equal_to: proc { Date.current.year },
    only_integer: true
  }

  scope :active, -> { where active: true }
  scope :retired, -> { where active: [nil, false] }

  def current_year
    proc { Date.current.year }
  end

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.size}"
  end

  def restart
    self.year = 2018
    puts "changed year to #{year}"
  end
end
