require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }
  let!(:beer1) { FactoryBot.create :beer, name: "iso 3", brewery: brewery }
  let!(:beer2) { FactoryBot.create :beer, name: "Karhu", brewery: brewery }
  let!(:user) { FactoryBot.create :user }

  before :each do
    sign_in(username: "Pekka", password: "Foobar1")
  end

  describe "when ratings exist" do
    before :each do
      rating1 = FactoryBot.create :rating, beer: beer1, user: user
      rating2 = FactoryBot.create :rating, beer: beer2, user: user
      visit ratings_path
    end

    it "page lists existing ratings and their total number" do
      expect(page).to have_content "Number of ratings: 2"
      expect(page).to have_content "iso 3: 10"
      expect(page).to have_content "Karhu: 10"
    end
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from: 'rating[beer_id]')
    fill_in('rating[score]', with: '15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end
end