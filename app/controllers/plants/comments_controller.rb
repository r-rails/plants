# frozen_string_literal: true

module Plants
  class CommentsController < CommentsController
    private

    def set_commentable
      @commentable = Plant.find(params[:plant_id])
    end
  end
end
