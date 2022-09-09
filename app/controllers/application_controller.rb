# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :persist_last_visited_path
  before_action :reset_notification_count, if: :current_user

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  def persist_last_visited_path
    session[:last_visited_path] = request.path unless Rails.configuration.ignored_paths.include?(request.path) || request.path == "/users/confirmation"
  end

  def reset_notification_count
    @unread_count ||= current_user.notifications.unread.count
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
      if resource.is_a?(User) && Rails.configuration.ignored_paths.exclude?(request.path)
        super
      else
        session[:last_visited_path].present? ? session[:last_visited_path] : root_path
      end
  end
end
