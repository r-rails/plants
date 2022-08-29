require "rails_helper"

RSpec.describe "Home Page", type: :system do
  before do
    5.times { create(:garden_plant) }
  end

  it "displays the top 10 most added plants in the dB" do
    visit root_path
    expect(page).not_to have_text(Plant.first.latin)

    click_link "Top 10"
    expect(page).to have_text(Plant.first.latin)

    click_link "Most Recent"
    expect(page).not_to have_text(Plant.first.latin)
  end
end
