class RatingJob
  include SuckerPunch::Job

  def perform
    puts "\n#{self.class.name}: Starting write to cache..."

    puts "   - Beer top 3..."
    Rails.cache.write("Beer-top-3", Beer.top(3))

    puts "   - Brewery top 3..."
    Rails.cache.write("Brewery-top-3", Brewery.top(3))

    puts "   - Style top 3..."
    Rails.cache.write("Style-top-3", Style.top(3))

    puts "   - User top 3..."
    Rails.cache.write("User-top-3", User.top(3))

    puts "   - Rating recent 5..."
    Rails.cache.write("Rating-recent-5", Rating.recent(5))

    time = 10.hours
    puts "Done. Sleeping for #{time} seconds..."
    RatingJob.perform_in(time)
  end
end
