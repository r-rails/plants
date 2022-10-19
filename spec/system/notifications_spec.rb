RSpec.describe "Notifications", type: :system do
  describe "GET /index" do
    context "when another user has made a comment on a user's plant" do
      let(:test_plant) { create(:plant) }

      before :each do
        @current_user = FactoryBot.create(:user, email: "qwerty@asdf.info", username: "donald-trump")
        # @current_user.confirm
        login_as @current_user, scope: :user
        visit plant_path(test_plant)
        click_on "add"
        visit plant_path(test_plant)
        delete destroy_user_session_path

        @another_user = FactoryBot.create :user
        # @another_user.confirm
        login_as @another_user, scope: :user
        visit plant_path(test_plant)
        page.execute_script("document.getElementById('comment_body_trix_input_comment').value = '<div>Microphone Check</div>'")
        click_button "Post comment"
        delete destroy_user_session_path
        login_as @current_user, scope: :user
        visit plants_path
      end

      it "expects there be a notification count of 1 on the header" do
        expect(page).to have_css("div#counter", text: "1")
      end

      context "When the notified user clicks on the notification button" do
        before :each do
          click_link(href: "/notifications")
        end

        it "takes the user to the list of notifications" do
          expect(page).to have_content("Microphone Check")
        end
      end

      context "When on the notifications page" do
        before :each do
          click_link(href: "/notifications")
        end

        it "marks notification for a plant as read when the plant page is visited" do
          visit plant_path(test_plant)
          expect(Notification.where(read_at: nil).count).to eq(0)
          expect(Notification.count).to eq(1)
        end

        it "marks the notification as read when `Mark as read` is clicked and reduces the notification count and vice versa" do
          click_on "Mark as read"

          expect(page).to have_content("Mark as unread")
          expect(page).to have_css("div#counter", text: "0")
          expect(Notification.where(read_at: nil).count).to eq(0)
          expect(Notification.count).to eq(1)

          click_on "Mark as unread"

          expect(page).to have_content("Mark as read")
          expect(page).to have_css("div#counter", text: "1")
          expect(Notification.where(read_at: nil).count).to eq(1)
          expect(Notification.count).to eq(1)
        end

        it "destroys the notification when Delete button is clicked and reduces the notification count" do
          expect(page).to have_content("Delete")

          click_on "Delete"

          expect(page).to have_css("div#counter", text: "0")
          expect(Notification.where(read_at: nil).count).to eq(0)
          expect(Notification.count).to eq(0)
        end
      end
    end
  end
end
