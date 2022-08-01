# frozen_string_literal: true

module UserHelper
  def list_app_users
    render_haml <<-HAML
      - User.all.each do |user|
        %ul.p-2.hover:underline
          %li= link_to user.username.capitalize, profile_path(user)
    HAML
  end
end
