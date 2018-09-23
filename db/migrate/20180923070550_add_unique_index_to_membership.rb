class AddUniqueIndexToMembership < ActiveRecord::Migration[5.2]
  def change
    add_index :memberships, [:beer_club_id, :user_id], unique: true
  end
end
