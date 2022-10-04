class PopulateUsersCommentsCount < ActiveRecord::Migration[7.0]
  def up
    User.find_each do |user|
      User.reset_counters(user.id, :comments)
    end
  end
end
