describe UserPresenter do
  include ActionView::TestCase::Behavior

  let!(:user1) { create(:user, status: 'admin') }
  let!(:user2) { create(:user, status: 'admin') }
  let!(:user3) { create(:user) }
  let!(:shared_presenter) { UserPresenter.new(user1, view) }

  context "#update_user_admin_status" do
    it "it creates a link to make user an admin when regular" do
      presenter = UserPresenter.new(user3, view)
      link = presenter.update_user_admin_status(user1)
      expect(link).to include("/update_status?slug=#{user3.slug}")
      expect(link).to include("Make admin")
    end

    it "it creates a link to make user a regular when admin" do
      presenter = UserPresenter.new(user2, view)
      link = presenter.update_user_admin_status(user1)

      expect(link).to include("/update_status?slug=#{user2.slug}")
      expect(link).to include("Remove admin status")
    end
  end

  context "#user_profile_greeting" do
    it "displays a string with signed_in user email when present" do
      message_string = shared_presenter.user_profile_greeting(user1)
      expect(message_string).to eq("<div>Signed in as #{user1.email}</div>")
    end

    it "displays a link to sign_in page when absent" do
      message_string = shared_presenter.user_profile_greeting(nil)
      expect(message_string).to include("/users/sign_in")
      expect(message_string).to include("Sign in")
    end
  end

  context "#user_avatar_display" do
    it "creates an image tag with the user's avatar" do
      image_link_string = shared_presenter.user_avatar_display
      expect(image_link_string).to include("img src=")
      expect(image_link_string).to include("rails/active_storage/blobs/redirect")
    end
  end

  context "#link_to_user_page" do
    it "creates an anchor tag to user profile page" do
      profile_link = shared_presenter.link_to_user_page
      expect(profile_link).to include("/#{user1.slug}")
      expect(profile_link).to include(user1.username)
    end
  end
end