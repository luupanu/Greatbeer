require 'rails_helper'

include Helpers

describe "Style" do
  let!(:user) { FactoryBot.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "lists all the styles" do
    FactoryBot.create :style, name: 'style1'
    FactoryBot.create :style, name: 'style2'
    FactoryBot.create :style, name: 'style3'

    visit styles_path

    expect(page).to have_content 'style1'
    expect(page).to have_content 'style2'
    expect(page).to have_content 'style3'
  end

  it "creation is successful" do
    visit new_style_path
    fill_in('style[name]', with: 'style4')
    fill_in('style[description]', with: 'deskribtio')

    expect {
      click_button 'Create Style'
    }.to change{ Style.count }.from(0).to(1)

    expect(Style.first.name).to eq('style4')
    expect(Style.first.description).to eq('deskribtio')
  end
end