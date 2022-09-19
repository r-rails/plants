RSpec.describe "plants/:id (Plant Show Page)", type: :system do
  context "When a user is not logged in" do
    let(:test_plant) { create(:plant) }
    before :each do
      visit plant_path(test_plant)
    end
    it "shows the plant" do
      expect(page).to have_content(test_plant.latin)
    end

    it "does not allow user to comment on the plant" do
      expect(page).to have_content("Login first to post a comment")
    end

    it "does not allow user to add plant to garden" do
      expect(page).to have_content("Sign in to plant your garden")
    end
  end

  context "When a user is logged in" do
    let(:test_plant) { create(:plant) }

    before :each do
      @user = FactoryBot.create :user
      # @user.confirm
      login_as @user, scope: :user
      visit plant_path(test_plant)
    end

    it "allows user to comment (CRUD) on the plant" do
      expect(page.has_field?("comment[body]", type: :hidden)).to be true

      page.execute_script("document.getElementById('comment_body_trix_input_comment').value = '<div>Microphone Check</div>'")

      click_button "Post comment"

      expect(page).to have_content "Microphone Check"
      expect(page).to have_content @user.username
      expect(page).to have_selector(:link_or_button, "edit")
      expect(page).to have_selector(:link_or_button, "delete")
    end

    it "does not allow a user to delete or edit another user's comment" do
      page.execute_script("document.getElementById('comment_body_trix_input_comment').value = '<div>Microphone Check</div>'")
      click_button "Post comment"

      click_button "Exit" # The logout helper seem to fail, so this is a compromise.

      @another_user = FactoryBot.create(:user, email: "qwerty@asdf.info", username: "donald-trump")
      # @another_user.confirm
      login_as @another_user, scope: :user

      visit plant_path(test_plant)

      expect(page).to have_content "Microphone Check"

      expect(page).not_to have_selector(:link_or_button, "edit")
      expect(page).not_to have_selector(:link_or_button, "delete")
    end

    it "allows user to add plant to garden" do
      expect(page).to have_selector(:link_or_button, "add")

      click_button "add"

      expect(page).to have_selector(:link_or_button, "remove")

      expect(test_plant.users).to include(@user).once
    end
  end
end
