class PlantsDataSeed < SeedMigration::Migration
  def up
  #Seed DB with 
  #name latin ideallight watering climate category
  all_plants = JSON.parse(File.read(Rails.root.join('db/house-plants.json')))

  all_plants.each do |plant|
    Plant.create(
      name: plant['common'][0],
      latin: plant['latin'],
      ideallight: plant['ideallight'],
      watering: plant['watering'],
      climate: plant['climate'],
      category: plant['category']
    )
  end
end

  def down
    #Clear all data in DB 
    Plant.delete_all
  end
end