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

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_brewery
    return nil if ratings.empty?

    largest_hash_key(avg_score_by_brewery)
  end

  def favorite_style
    return nil if ratings.empty?

    largest_hash_key(avg_score_by_style)
  end

  def member_of?(beer_club)
    beer_club.members.exists?(id)
  end

  private

  def largest_hash_key(hash)
    hash.max_by { |_, v| v }[0]
  end

  def avg_score_by_style
    # get an array of arrays [[style, score], ...]
    styles = ratings.map { |r| [r.beer.style, r.score] }
    # group by style { style => [[style, score]], ... }
    styles = styles.group_by(&:first)
    # make value the average of scores { style => avg_score }
    styles.map { |k, v| [k, v.map(&:last).reduce(:+) / v.size.to_f] }
  end

  def avg_score_by_brewery
    # get an array of arrays [[brewery, score], ...]
    styles = ratings.map { |r| [r.beer.brewery, r.score] }
    # group by style { style => [[brewery, score]], ... }
    styles = styles.group_by(&:first)
    # make value the average of scores { brewery => avg_score }
    styles.map { |k, v| [k, v.map(&:last).reduce(:+) / v.size.to_f] }
  end
end
