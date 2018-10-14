namespace :migrate do
  desc 'Migrate all beer styles from beers table to styles table'
  task styles: :environment do
    beers = Beer.all
    styles = beers.map(&:old_style).uniq

    ActiveRecord::Base.transaction do
      puts "Adding #{styles.count} styles..."
      styles.each do |style|
        if style
          Style.create name: style
        end
      end

      puts "Updating new styles to all beers..."

      beers.each do |beer|
        new_style = Style.find_by name: beer.old_style
        if new_style
          beer.style = new_style
          beer.save
        else
          puts "Error finding style #{beer.old_style} for beer #{beer}"
        end
      end
    end

    puts "Done."
  end
end
