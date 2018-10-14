require 'rails_helper'

RSpec.describe Style, type: :model do
  it "is saved with a proper name and description" do
    style = FactoryBot.create :style

    expect(style).to be_valid
    expect(Style.count).to eq(1)
  end

  describe "that is otherwise valid" do

    it "is not saved without a name" do
      style = Style.create description: "jahas"

      expect(style).to_not be_valid
      expect(Style.count).to eq(0)
    end

    it "is not saved without a description" do
      style = Style.create name: "juhuu"

      expect(style).to_not be_valid
      expect(Style.count).to eq(0)
    end
  end
end
