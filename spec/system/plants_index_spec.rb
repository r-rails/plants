RSpec.describe "plants_index_page", type: :system do
  before :each do
    create_list(:plant, 15)
  end

  it "displays the list of all plants in the dB paginated by size 12" do
    visit plants_path
    first_plants_set_latin = Plant.order(:latin).limit(12).pluck(:latin)
    second_plants_set_latin = Plant.order(:latin).limit(12).offset(12).pluck(:latin)

    # First page should only contain the first 12 plants
    expect(first_plants_set_latin.all? { |latin| page.html.include?(latin) }).to be true
    expect(second_plants_set_latin.any? { |latin| page.html.include?(latin) }).to be false

    click_link "Next ›", match: :first

    # Second page should only contain the next set of 12 plants e.t.c
    expect(first_plants_set_latin.all? { |latin| page.html.include?(latin) }).to be false
    expect(second_plants_set_latin.any? { |latin| page.html.include?(latin) }).to be true
  end

  it "clicking on a plant name should take the user to the plant page" do
    visit plants_path
    first_plant = Plant.order(:latin).first 

    click_link first_plant.name, match: :first

    expect(page).to have_content first_plant.name
    expect(page).to have_content first_plant.latin
    expect(page).to have_content first_plant.watering
  end
end
