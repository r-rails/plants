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

    it "allows user to add plant in the garden" do
      expect(page).to have_selector(:link_or_button, "add")

      click_on "add"

      expect(test_plant.users).to include(@user).once
    end

    it "allows user to remove plant from the garden" do
      expect(page).to have_selector(:link_or_button, "add")

      click_on "add"
      expect(test_plant.users).to include(@user).once

      expect(page).to have_selector(:link_or_button, "remove")

      click_on "remove"

      expect(test_plant.users).not_to include(@user).once
    end
  end

  context "When a user hovers on plant category links" do
    let(:test_plant) { create(:plant) }
    before :each do
      visit plant_path(test_plant)
    end
    it "displays a card to inform the user that the link can direct the user to other plants of the same category" do
      find(".cursor-pointer.plant-category").hover
      expect(page).to have_content("Сlick here to see all plants of #{test_plant.category} category")
    end
  end

  context "when a signed in user wants to make a comment on the plant" do
    let(:test_plant) { create(:plant) }
    before :each do
      @user = FactoryBot.create :user
      # @user.confirm
      login_as @user, scope: :user
      visit plant_path(test_plant)
    end

    it "does not allow a user to create an empty comment" do
      click_button "Post comment"

      expect(page).to have_content("Comment needs to have actual content")
    end

    it "allows user to comment on the plant" do
      expect(page.has_field?("comment[body]", type: :hidden)).to be true

      page.execute_script("document.getElementById('comment_body_trix_input_comment').value = '<div>Microphone Check</div>'")
      click_button "Post comment"
      expect(page).to have_content "Microphone Check"
      expect(page).to have_content @user.username
      expect(Comment.count).to eq 1
    end
  end
end
