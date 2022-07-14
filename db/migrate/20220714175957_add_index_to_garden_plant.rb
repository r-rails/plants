class AddIndexToGardenPlant < ActiveRecord::Migration[7.0]
  def change
    add_index :garden_plants, [ :user_id, :plant_id ], :unique => true, :name => 'by_user_and_plant'
  end
end
