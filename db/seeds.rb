# This file is auto-generated from the current content of the database. Instead
# of editing this file, please use the migrations feature of Seed Migration to
# incrementally modify your database, and then regenerate this seed file.
#
# If you need to create the database on another system, you should be using
# db:seed, not running all the migrations from scratch. The latter is a flawed
# and unsustainable approach (the more migrations you'll amass, the slower
# it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

all_plants = JSON.parse(File.read(Rails.root.join("db/house-plants.json")))

all_plants.each do |plant|
  Plant.create(
    name: plant["common"][0],
    latin: plant["latin"],
    ideallight: plant["ideallight"],
    watering: plant["watering"],
    climate: plant["climate"],
    category: plant["category"]
  )
end
