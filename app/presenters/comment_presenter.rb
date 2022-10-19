class CommentPresenter < BasePresenter
  presents :comment

  def edit_action(viewer, owner)
    return unless viewer&.== owner

    _h_.link_to("edit", [:edit, comment.commentable, comment], class: "rounded border bg-neutral-100 px-3 py-1 text-xs")
  end

  def delete_action(viewer, owner)
    return unless viewer&.== owner

    _h_.link_to("delete", [comment.commentable, comment], data: {turbo_method: :delete, turbo_confirm: "Are you sure?"}, class: "rounded border bg-neutral-100 px-3 py-1 text-xs")
  end
end
