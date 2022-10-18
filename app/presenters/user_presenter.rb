class UserPresenter < BasePresenter
  presents :user

  def update_user_admin_status(current_user)
    if current_user&.admin? && current_user != user
      link_to(user.admin? ? "Remove admin status" : "Make admin", update_status_path(slug: user), class: 'btn-primary')
    end
  end

  def user_profile_greeting(visitor)
    if visitor
        return tag.div("Signed in as #{visitor.email}.")
    else
      link_to("Sign in", new_user_session_path, class: "text-blue-500")
    end
  end

  def user_avatar_display
    if user.avatar.attached?
      image_tag(user.avatar, size: '100')
    else 
      render_haml <<-HAML
      .h-10.w-10.rounded-full{:class => "bg-[url('https://i.pravatar.cc/32')]"}
      HAML
    end
  end

  def link_to_user_page(html_options)
    link_to(user.username, profile_path(user), data: html_options[:data], class: html_options[:class])
  end
end