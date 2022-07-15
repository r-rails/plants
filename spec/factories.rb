FactoryBot.define do
  factory(:user) do
    email { 'abc@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    username { 'john_doe' } 
  end
  
  factory(:plant) do
    description { Faker::Lorem.sentence }
    name { Faker::Lorem.word }
    climate { "Sunnytime" }
    latin { "Aeschynanthus lobianus" }
    category { "Hanging" }
    ideallight { "Bright light" }
    watering { "Keep moist between watering. Can be a bit dry between watering" }
  end
end
