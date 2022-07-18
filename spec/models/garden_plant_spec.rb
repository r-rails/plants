RSpec.describe GardenPlant, :type => :model do 
  describe "garden creation by model" do 
    context "garden association" do 
      it { should belong_to(:user) }
      it { should belong_to(:plant) }
    end

    context "garden validations" do 
      it { should validate_presence_of(:user) }
    end
  end
end