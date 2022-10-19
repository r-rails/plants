describe PlantPresenter do
  include ActionView::TestCase::Behavior
  
  let!(:plant) { create(:plant) }
  let!(:user) { create(:user) }
  let!(:subject) { PlantPresenter }
  let!(:shared_presenter) { subject.new(plant, view) }

  xcontext "#add_plant_to_garden" do
    it "returns a button to for a user to add a plant to garden if plant not present else remove the plant" do
      wrapper = shared_presenter.add_plant_to_garden(user)
      expect(wrapper).to include("value=\"add")
      expect(wrapper).to include("/add_to_garden")
      new_user = create(:user)

      create(:garden_plant, user: new_user, plant: plant)

      wrapper = shared_presenter.add_plant_to_garden(new_user)
      expect(wrapper).to include("value=\"remove")
      expect(wrapper).to include("/garden_plant")
    end
  end

  xcontext "#plant_img" do
    it "returns an image tag with a default image for a plant" do
      wrapper = shared_presenter.plant_img
      expect(wrapper).to include("/rails/active_storage/blobs/redirect/")
      expect(wrapper).to include("#{plant.name}.svg")
    end
  end

  xcontext "#link_to_plant_page" do
    it "returns a link to the plant page" do
      wrapper = shared_presenter.link_to_plant_page
      expect(wrapper).to include("/plants/#{plant.slug}")
    end
  end

  context "#show_plant_comments" do
    it "shows a template message when plant has no comment" do
      wrapper = shared_presenter.show_plant_comments
      expect(wrapper).to include("Be first to comment on this plant!") 
    end
  end
end
