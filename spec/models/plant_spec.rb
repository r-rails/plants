
RSpec.describe Plant, :type => :model do
  describe "plants creation by the model" do
    context "with valid attributes" do 
      let(:plant) { create(:plant) } 
      it "creates a plant object" do
        expect(plant.valid?).to be true
        expect(Plant.count).to eq(1)
        expect(Plant.first.description).to eq(plant.description)
      end
    end

    context "with invalid attributes" do
      let (:plant) { build(:plant, name: "") }
      it "does not create a plant object" do
        expect(plant.valid?).to be false
        expect(Plant.count).to eq(0)
      end
    end
  end 
end