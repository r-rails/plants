class PopulateUsersPlantsCount < ActiveRecord::Migration[7.0]
  def up
    User.find_each do |user|
      User.reset_counters(user.id, :garden_plants)
    end
  end
end
