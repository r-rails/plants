class CommentPresenter < BasePresenter
  presents :comment

  def edit_action(viewer, owner)
    return unless viewer&.== owner

    _h_.content_tag :div, class: "rounded border bg-neutral-100 px-3 py-1 text-xs" do
      _h_.link_to("edit", [:edit, comment.commentable, comment])
    end
  end

  def delete_action(viewer, owner)
    return unless viewer&.== owner

    _h_.content_tag :div, class: "rounded border bg-neutral-100 px-3 py-1 text-xs" do
      _h_.link_to("delete", [comment.commentable, comment], data: {turbo_method: :delete, turbo_confirm: "Are you sure?"})
    end
  end
end
