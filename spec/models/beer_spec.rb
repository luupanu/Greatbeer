require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "is saved with a proper name, style and brewery" do
      beer = FactoryBot.create :beer

      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end
  
  describe "that is otherwise valid" do
    let(:brewery) { FactoryBot.create :brewery }
    let(:style) { FactoryBot.create :style }

    it "is not saved without a brewery" do
      beer = Beer.create name: "Karhu", style: style

      expect(beer).to_not be_valid
      expect(Beer.count).to eq(0)
    end

    it "is not saved without a name" do
      beer = Beer.create brewery: brewery, style: style

      expect(beer).to_not be_valid
      expect(Beer.count).to eq(0)
    end

    it "is not saved without a style" do
      beer = Beer.create name: "Karhu", brewery: brewery

      expect(beer).to_not be_valid
      expect(Beer.count).to eq(0)
    end
  end
end
