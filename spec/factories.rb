# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    recipient { nil }
    type { "" }
    params { "" }
    read_at { "2022-09-04 15:56:47" }
  end

  factory(:user) do
    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }
    username { Faker::Name.name }
  end

  factory(:plant) do
    description { Faker::Lorem.sentence }
    name { Faker::Lorem.word }
    climate { "Sunnytime" }
    latin { Faker::Lorem.sentence(word_count: 2) }
    category { Faker::Lorem.word.capitalize }
    ideallight { "Bright light" }
    watering { "Keep moist between watering. Can be a bit dry between watering" }
  end

  factory(:comment) do
    body { Faker::Lorem.sentence(word_count: 7) }
    association :commentable, factory: :plant
    commentable_type { "Plant" }
    commentable_id { commentable.id }
    deleted_at { nil }
    user
  end

  factory(:garden_plant) do
    user
    plant
  end
end
