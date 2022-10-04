class AddPlantsCountToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :plants_count, :integer, default: 0
  end
end
