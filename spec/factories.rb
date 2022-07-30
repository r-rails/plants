FactoryBot.define do
  # factory :comment do
  #   user { nil }
  #   body { "MyText" }
  #   commentable { nil }
  #   deleted_at { "2022-07-30 18:15:24" }
  # end

  # factory :comment do
  #   plant { nil }
  #   user { nil }
  # end

  factory(:user) do
    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }
    username { "john_doe" }
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

  # factory(:comment) do
  #   body { Faker::Lorem.sentence(word_count: 7) }
  #   user
  #   plant
  # end
end
