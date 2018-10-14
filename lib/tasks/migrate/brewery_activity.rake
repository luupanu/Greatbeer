namespace :migrate do
  desc 'Mark all breweries as active'
  task breweries: :environment do
    breweries = Brewery.all

    ActiveRecord::Base.transaction do
      puts "Updating #{breweries.count} breweries..."
      Brewery.all.each do |brewery|
        brewery.active = true
        brewery.save
      end
    end

    puts "Done."
  end
end
