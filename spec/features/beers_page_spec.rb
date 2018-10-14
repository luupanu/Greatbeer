require 'rails_helper'

include Helpers

describe "Beer" do
  let!(:user) { FactoryBot.create :user }
  let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }
  let!(:style) { FactoryBot.create :style }

  before :each do
    sign_in(username: "Pekka", password: "Foobar1")
  end

  describe "when creating Beer" do
    it "a valid Beer is added to the system" do
      visit new_beer_path
      fill_in('beer[name]', with: 'Karhu')

      expect{
        click_button "Create Beer"
      }.to change{ Beer.count }.from(0).to(1)

      expect(brewery.beers.count).to eq(1)
      expect(style.beers.count).to eq(1)
    end

    it "it is not added if invalid name provided" do
      visit new_beer_path

      click_button "Create Beer"

      expect(page).to have_content "Name can't be blank"
      expect(Beer.count).to eq(0)
    end
  end

end