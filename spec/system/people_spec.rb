RSpec.describe "People page", type: :system do
  context "when a the people link is clicked on the navbar" do
    let!(:people) { create_list(:user, 5) }
    it "directs the user to a page listing all users" do
      visit people_path
      expect(people.all? { |user| page.html.include?(user.username) }).to be true
    end
  end
  
end