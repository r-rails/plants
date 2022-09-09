RSpec.describe "Notifications", type: :system do
  describe "GET /index" do
    context "when another user has made a comment on a user's plant" do
      let(:test_plant) { create(:plant) }
      
      before :each do
        @current_user = FactoryBot.create(:user, email: "qwerty@asdf.info", username: "donald-trump")
        @current_user.confirm
        login_as @current_user, scope: :user
        visit plant_path(test_plant)
        click_on "add"
        click_button "Exit" # Logs out to allow another user make comment

        @another_user = FactoryBot.create :user
        @another_user.confirm
        login_as @another_user, scope: :user
        visit plant_path(test_plant)
        page.execute_script("document.getElementById('comment_body_trix_input_comment').value = '<div>Microphone Check</div>'")
        click_button "Post comment"
        click_button "Exit" # Logs out so the first user can check notifications
      end

      it "expects there be a notification count of 1 on the header" do
        login_as @current_user, scope: :user
        visit root_path

        expect(page).to have_css('span#counter')
      end

    
    end
  end
end
