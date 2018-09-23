class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings

  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  validates :username,  uniqueness: { case_sensitive: false },
                        length: { in: 3..30 },
                        on: :create

  validates :password,  length: { minimum: 4 },
                        format: {
                          without: /\A([^0-9]+|[^A-Z]+)\z/,
                          message: 'must contain at least one uppercase letter (A-Z) and one number (0-9)'
                        }
end
