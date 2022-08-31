RSpec.describe "Home Page", type: :system do
  before do
    create_list(:garden_plant, 15)
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
      first_category = Plant.pluck(:category).uniq.min

      visit root_path

      click_link "Top 10"

      expect(page.has_field?("q[category_cont]", type: :hidden, with: first_category)).to be false

      click_link "Most Recent"

      expect(page.has_field?("q[category_cont]", type: :hidden, with: first_category)).to be false

      click_link "Categories"

      expect(page.has_field?("q[category_cont]", type: :hidden, with: first_category)).to be true
    end
  end

  context "when Top growers link is clicked" do
    it "only displays card for users who have at least one plant in their garden" do
      farmed_users = User.joins(:plants).uniq.pluck(:username)
      unfarmed_user = create(:user).username

      visit top_growers_path

      expect(farmed_users.all? { |username| page.html.include?(username) }).to be true
      expect(page).not_to have_content(unfarmed_user)
    end
  end
end
