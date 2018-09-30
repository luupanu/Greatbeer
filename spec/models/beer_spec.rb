require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "is saved with a proper name, style and brewery" do
      beer = FactoryBot.create(:beer)

      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end
  
  describe "with a proper brewery" do
    let(:test_brewery) { Brewery.new name:"test", year: 2000 }

    it "is not saved without a name" do
      beer = Beer.create style: "teststyle", brewery: test_brewery

      expect(beer).to_not be_valid
      expect(Beer.count).to eq(0)
    end

    it "is not saved without a style" do
      beer = Beer.create name: "Karhu", brewery: test_brewery

      expect(beer).to_not be_valid
      expect(Beer.count).to eq(0)
    end
  end
end
