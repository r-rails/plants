RSpec.describe Notification, type: :model do
  describe "notification creation by the model" do
    context "when a comment is made on a plant with users" do
      let!(:plant) { create(:plant) }
      let!(:users) { create_list(:user, 6) }
      let!(:garden_plants) { users.each { |user| create(:garden_plant, plant_id: plant.id, user: user) } }
      it "created notifications for all plant users except the comment user" do
        comment_1 = create(:comment, commentable_id: plant.id, user_id: users.first.id)
        
        expect(Notification.count).to eq(5)
        expect(Notification.ids).not_to include(users.first.id)
        
      end
    end
  end
end
