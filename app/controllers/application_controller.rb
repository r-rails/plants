# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :persist_last_visited_path

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  def persist_last_visited_path
    unless Rails.configuration.ignored_paths.include?(request.path)
      session[:last_visited_path] = request.path
    end
  end

  def after_sign_in_path_for(resource)
    if session[:last_visited_path].present?
      session[:last_visited_path]
    else
      root_path
    end
  end
end
