describe CommentPresenter do
  include ActionView::TestCase::Behavior

  let!(:user1) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:comment) { create(:comment, user: user1) }
  let!(:subject) { CommentPresenter }
  let!(:shared_presenter) { subject.new(comment, view) }

  context "#edit_action" do
    it "returns nil when the viewing user is not the comment creator" do
      wrapper = shared_presenter.edit_action(user2, user1)
      expect(wrapper).to be_nil
    end

    it "returns a comment edit link when the user is the comment creator" do
      wrapper = shared_presenter.edit_action(comment.user, user1)
      expect(wrapper).to include("plants/#{comment.commentable.slug}/comments/#{comment.id}/edit")
    end
  end

  context "#delete_action" do
    it "returns nil when the viewing user is not the comment creator" do
      wrapper = shared_presenter.delete_action(user2, user1)
      expect(wrapper).to be_nil
    end

    it "returns a comment edit link when the user is the comment creator" do
      wrapper = shared_presenter.delete_action(comment.user, user1)
      expect(wrapper).to include("plants/#{comment.commentable.slug}/comments/#{comment.id}")
    end
  end
end
