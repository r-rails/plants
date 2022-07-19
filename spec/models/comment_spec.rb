RSpec.describe Comment, :type => :model do 
  describe "comment creation by Comments model" do 
    context "with validated attributes" do
      let!(:comment) { create(:comment) }

      it "creates a valid comment object into the database" do
        expect(comment.valid?).to be true
        expect(Comment.count).to eq(1)
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

    context "Model Associations" do
      it "should belong to a Plant model" do
        plant_association = Comment.reflect_on_association(:plant)
        expect(plant_association.macro).to eq(:belongs_to)
      end

      it "should belong to a User model" do
        user_association = Comment.reflect_on_association(:user)
        expect(user_association.macro).to eq(:belongs_to)
      end
    end
  end
end
