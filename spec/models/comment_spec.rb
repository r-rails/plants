# frozen_string_literal: true

RSpec.describe Comment, type: :model do
  describe 'comment creation by Comments model' do
    context 'with validated attributes' do
      let!(:user) { create(:user) }
      let!(:commentable) { create(:plant) }
      let!(:comment) { create(:comment, user_id: user.id, commentable_id: commentable.id, commentable_type: 'Plant') }

      it 'creates a valid comment object into the database' do
        expect(comment.valid?).to be true
        expect(Comment.count).to eq(1)
      end
    end

    context 'when plant_id is not present' do
      let!(:comment) { build(:comment) }

      it 'does not create a new comment' do
        expect(comment.valid?).to be false
        expect(Comment.count).to eq(0)
      end
    end

    context 'when user_id is not present' do
      let!(:comment) { build(:comment, user: nil) }

      it 'does not create a new comment' do
        expect(comment.valid?).to be false
        expect(Comment.count).to eq(0)
      end
    end

    context 'Model Associations' do
      it 'should belong to a commentable' do
        commentable_association = Comment.reflect_on_association(:commentable)
        expect(commentable_association.macro).to eq(:belongs_to)
      end

      it 'should belong to a User model' do
        user_association = Comment.reflect_on_association(:user)
        expect(user_association.macro).to eq(:belongs_to)
      end
    end
  end
end
