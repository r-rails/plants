# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


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