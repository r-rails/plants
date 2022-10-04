class AddUsersCountToPlants < ActiveRecord::Migration[7.0]
  def change
    add_column :plants, :users_count, :integer, default: 0
  end
end
