RSpec.describe 'Login with Google auth', type: :system do
  context "when the user has a valid gmail account" do
    before do
      Rails.application.env_config["devise.mapping"] = Devise.mappings[:user] # If using Devise
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
    end

    it "signs in the user when they click on google button" do 
      visit new_user_session_path

      expect(page).to have_selector(:link_or_button, 'Sign in with GoogleOauth2')
      click_on 'Sign in with GoogleOauth2'
      expect(page).to have_content("Successfully authenticated from Google account")
    end
  end

  context "when the user has no gmail account" do
    before do
      OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
    end

    it "returns an error and does not sign the user in." do 
      visit new_user_session_path

      expect(page).to have_selector(:link_or_button, 'Sign in with GoogleOauth2')
      click_on 'Sign in with GoogleOauth2'
      expect(page).to have_content("Could not authenticate you from GoogleOauth2")
    end
  end
end