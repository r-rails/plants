# frozen_string_literal: true

RSpec.describe User, type: :model do
  describe "user creation by the model" do
    context "with valid attributes" do
      let(:user) { create(:user) }
      it "creates a user object" do
        expect(user.valid?).to be true
        expect(User.count).to eq(1)
        expect(User.first.username).to eq(user.username)
      end
    end

    context "with invalid attributes" do
      let(:user) { build(:user, email: "example@") }
      it "does not create a user object" do
        user.save
        expect(user.errors.messages[:email]).to eq(["is invalid"])
        expect(user.valid?).to be false
        expect(User.count).to eq(0)
      end
    end

    context "when a user has been successfully created" do
      let(:user) { create(:user) }
      it "does not allow the slug to be updated" do
        user.slug = "changed-slug"
        expect(user.save).to be false
      end
    end
  end
end
