class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:notice] = "Your comment has been added successfully"
    else
      flash[:error] = "Comment should contain mininum of 10 characters"
    end
    redirect_to plant_path(@comment.plant)
  end

  private

  def comment_params
    params.permit(:body, :user_id, :plant_id)
  end
end
