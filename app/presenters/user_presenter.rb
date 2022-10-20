class UserPresenter < BasePresenter
  presents :user

  def update_user_admin_status(current_user)
    if current_user&.admin? && current_user != user
      _h_.link_to(user.admin? ? "Remove admin status" : "Make admin", update_status_path(slug: user), class: "btn-primary")
    end
  end

  def user_profile_greeting(visitor)
    if visitor
      tag.div("Signed in as #{visitor.email}")
    else
      _h_.link_to("Sign in", new_user_session_path, class: "text-blue-500")
    end
  end

  def user_avatar_display
    user.set_avatar unless user.avatar.attached?

    _h_.image_tag(user.avatar, size: "100")
  end

  def link_to_user_page(html_options = {})
    _h_.link_to(user.username, profile_path(user), data: html_options[:data], class: html_options[:class])
  end
end
