require 'rails_helper'

describe "Beerlist page" do
  before :all do
    Capybara.register_driver :selenium do |app|
      capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
        chromeOptions: { args: ['headless', 'disable-gpu'] }
      )

      Capybara::Selenium::Driver.new app,
        browser: :chrome,
        desired_capabilities: capabilities
    end
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  before :each do
    @brewery1 = FactoryBot.create(:brewery, name: "Koff")
    @brewery2 = FactoryBot.create(:brewery, name: "Schlenkerla")
    @brewery3 = FactoryBot.create(:brewery, name: "Ayinger")
    @style1 = Style.create(name: "Lager", description: "1")
    @style2 = Style.create(name: "Rauchbier", description: "2")
    @style3 = Style.create(name: "Weizen", description: "3")
    @beer1 = FactoryBot.create(:beer, name: "Nikolai", brewery: @brewery1, style: @style1)
    @beer2 = FactoryBot.create(:beer, name: "Fastenbier", brewery: @brewery2, style: @style2)
    @beer3 = FactoryBot.create(:beer, name: "Lechte Weisse", brewery: @brewery3, style: @style3)
  end

  describe "shows" do
    it "one known beer", js: true do
      visit beerlist_path
      expect(page).to have_content "Nikolai"
    end

    it "sorted by name by default", js: true do
      visit beerlist_path

      row1 = find('tbody').find('tr:nth-child(1)')
      expect(row1).to have_content "Fastenbier Rauchbier Schlenkerla"

      row2 = find('tbody').find('tr:nth-child(2)')
      expect(row2).to have_content "Lechte Weisse Weizen Ayinger"

      row3 = find('tbody').find('tr:nth-child(3)')
      expect(row3).to have_content "Nikolai Lager Koff"
    end
  end

  describe "when clicking" do
    it "style column, sorts beers by style", js: true do
      visit beerlist_path
      click_link 'style'

      row1 = find('tbody').find('tr:nth-child(1)')
      expect(row1).to have_content "Nikolai Lager Koff"

      row2 = find('tbody').find('tr:nth-child(2)')
      expect(row2).to have_content "Fastenbier Rauchbier Schlenkerla"

      row3 = find('tbody').find('tr:nth-child(3)')
      expect(row3).to have_content "Lechte Weisse Weizen Ayinger"
    end

    it "brewery column, sorts beers by brewery", js: true do
      visit beerlist_path
      click_link 'brewery'

      row1 = find('tbody').find('tr:nth-child(1)')
      expect(row1).to have_content "Lechte Weisse Weizen Ayinger"

      row2 = find('tbody').find('tr:nth-child(2)')
      expect(row2).to have_content "Nikolai Lager Koff"

      row3 = find('tbody').find('tr:nth-child(3)')
      expect(row3).to have_content "Fastenbier Rauchbier Schlenkerla"
    end
  end
end