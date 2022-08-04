# frozen_string_literal: true

module Motor
  class ApplicationController < ActionController::Base
    include Motor::CurrentUserMethod
    include Motor::CurrentAbility

    before_action do |controller|
      authenticate if Rails.env.production?
    end

    def authenticate
      authenticate_or_request_with_http_basic do |name, password|
        name == ENV["MOTOR_AUTH_USERNAME"] && password == ENV["MOTOR_AUTH_PASSWORD"]
      end
    end
  end
end
