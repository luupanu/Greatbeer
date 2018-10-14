require 'rails_helper'

describe "Places" do
  before :all do
    Capybara.ignore_hidden_elements = false
  end

  after :all do
    Capybara.ignore_hidden_elements = true
  end

  it "if one is returned by API, it is shown at the page" do
    allow(BeerMappingAPI).to receive(:places_in).with("kumpula").and_return(
      [Place.new(name:"Oljenkorsi", id: 1)]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if multiple returned by API, all is shown at the page" do
    places = [
      Place.new(name: "Pub Porthan", id: 2),
      Place.new(name: "Pub Sirdie", id: 3)
    ]

    allow(BeerMappingAPI).to receive(:places_in).with("kallio").and_return(places)

    visit places_path
    fill_in('city', with: 'kallio')
    click_button "Search"

    expect(page).to have_content "Pub Porthan", "Pub Sirdie"
  end

  it "if none returned by API, user is notified" do
    allow(BeerMappingAPI).to receive(:places_in).with("vantaa").and_return([])

    visit places_path
    fill_in('city', with: 'vantaa')
    click_button "Search"

    expect(page).to have_content "No locations in vantaa."
  end
end