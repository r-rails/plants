class PopulatePlantUsers < ActiveRecord::Migration[7.0]
  def up
    Plant.find_each do |plant|
      Plant.reset_counters(plant.id, :garden_plants)
    end
  end
end
