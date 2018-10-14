namespace :migrate do
  desc 'Make all users plebs'
  task admins: :environment do
    users = User.all

    ActiveRecord::Base.transaction do
      puts "Updating #{users.size} users..."
      users.each do |user|
        user.update_attribute(:admin, false)
      end
    end

    puts "Done."
  end
end
