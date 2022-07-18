RSpec.describe Comment, :type => :model do 
  describe "comment creation by model" do 
    context "with validated attributes" do
      it "must have a body length of minumum 10"

      it "must show user comments"

      it "must show all other user comments"
    end

    context "with invalid attributes" do
      it "does not create a user object" 
    end
  end
end