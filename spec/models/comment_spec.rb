RSpec.describe Comment, :type => :model do 
  describe "comment creation by Comments model" do 
    context "with validated attributes" do
      let!(:user) { create(:user) }
      let!(:plant) { create(:plant) }
      let!(:comment) { create(:comment, user: user, plant: plant) }

      it "creates a valid comment object into the database" do
        expect(comment.valid?).to be true
        expect(Comment.count).to eq(1)
      end

      it "creates an association between comment and the plant" do
        expect(comment.plant).to eq(plant)
      end

      it "creates an association between comment and the user" do
        expect(comment.user).to eq(user)
      end
    end

    context "when plant_id is not present" do
      let!(:user) { create(:user) }
      let!(:comment) { build(:comment, user: user, plant: nil) }

      it "does not create a new comment" do
        expect(comment.valid?).to be false
        expect(Comment.count).to eq(0)
      end
    end

    context "when user_id is not present" do
      let!(:plant) { create(:plant) }
      let!(:comment) { build(:comment, user: nil, plant: plant) }

      it "does not create a new comment" do
        expect(comment.valid?).to be false
        expect(Comment.count).to eq(0)
      end
    end
  end
end
