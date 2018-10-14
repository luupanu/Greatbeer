namespace :migrate do
  desc 'Make all users not banned'
  task banned: :environment do
    users = User.all

    ActiveRecord::Base.transaction do
      puts "Updating #{users.size} users..."
      users.each do |user|
        user.update_attribute(:banned, false)
      end
    end

    puts "Done."
  end
end
