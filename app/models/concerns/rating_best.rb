module RatingBest
  extend ActiveSupport::Concern

  included do
    def self.top(num = 0)
      sorted_by_avg_rating = all.sort_by { |i| -(i.average_rating || 0) }
      sorted_by_avg_rating[0..num - 1]
    end
  end
end
