RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.include Devise::TestHelpers, type: :view
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Warden::Test::Helpers
end
