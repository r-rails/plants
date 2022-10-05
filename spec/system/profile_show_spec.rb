RSpec.describe "Profile", type: :system do
  describe "a user profile page" do
    context "when the user exists" do
      let!(:user) { create(:user) }
      let!(:plant) { create(:plant) }
      let!(:garden_plant) { create( :garden_plant, user: , plant: ) }
      it "displays the user profile page along with plants in the user's garden" do
        visit profile_path(user)

        expect(page).to have_content(plant.latin)
        expect(page).to have_content("Welcome to #{user.username}'s garden!")
      end
    end

    context "when the user does not exists" do
      it "alerts that the user is not in the database" do
        visit profile_path(slug: "unavailable")
        expect(page).to have_content("User not found") 
      end
    end

    describe "when the signed in user is an admin" do
      let!(:admin_user) { create(:user, status: "admin") }
      let!(:another_admin_user) { create(:user, status: "admin") }
      let!(:regular_user) { create(:user) }
      before :each do
        login_as admin_user, scope: :user
      end
      context "and the user visits another user's page" do
        context "if the other user is not an admin" do
          it "shows a button that to make the user an admin" do
            visit profile_path(regular_user)
            expect(page).to have_selector(:link_or_button, "Make admin")

            click_on "Make admin"
            expect(page).to have_selector(:link_or_button, "Remove admin status")
            expect(User.admin.count).to eq 3
          end
        end
        
        context "if the other user is an admin" do
          it "shows a button that to make the user status to be regular" do
            visit profile_path(another_admin_user)
            expect(page).to have_selector(:link_or_button, "Remove admin status")

            click_on "Remove admin status"
            expect(page).to have_selector(:link_or_button, "Make admin")
            expect(User.admin.count).to eq 1
          end
        end
      end
    end
  end
end