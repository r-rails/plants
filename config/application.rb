# frozen_string_literal: true

require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Plants
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.active_storage.content_types_to_serve_as_binary -= ["image/svg+xml"]
    #
    # These paths will be ignored when redirecting the user to last visited page
    # Devise routes need to always be here, so that a redirect loop does not occur
    # after signing in
    config.ignored_paths = %W[/users/sign_in /users/sign_up /users/password /users/sign_out /users/confirm_password]
  end
end
