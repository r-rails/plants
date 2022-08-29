require "rails_helper"

RSpec.describe "Home Page", type: :system do
  before do
    15.times { create(:garden_plant) }
  end
  context "when the Top 10 tab is clicked" do
    it "displays the top 10 most added plants in the dB" do
      top_plant = create(:garden_plant, plant: Plant.first).plant
      no_user_plant = create(:plant)

      visit root_path
      expect(page).to have_text(no_user_plant.latin)

      click_link "Top 10"
      expect(page).not_to have_text(no_user_plant.latin)
      expect(page).to have_text(top_plant.latin)

      click_link "Most Recent"
      expect(page).to have_text(no_user_plant.latin)
    end
  end

  context "when the most recent tab is clicked" do
    it "displays the most recently created plants in the dB" do
      first_plant = Plant.order(created_at: :desc).first
      last_plant = Plant.order(created_at: :desc).last

      visit most_recent_plants_path

      expect(page).to have_text(first_plant.latin)
      expect(page).not_to have_text(last_plant.latin)
    end
  end

  context "when category tab is clicked" do
    it "displays the categories of the plants in the dB" do
      stubbed_plant = create(:plant, category: 'Aaaaaaaaaaaaa')

      visit root_path

      click_link "Top 10"

      expect(page.has_field? "q[category_cont]", type: :hidden, with: stubbed_plant.category).to be false

      click_link "Most Recent"

      expect(page.has_field? "q[category_cont]", type: :hidden, with: stubbed_plant.category).to be false

      click_link "Categories"

      expect(page.has_field? "q[category_cont]", type: :hidden, with: stubbed_plant.category).to be true
    end
  end
end
