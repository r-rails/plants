# frozen_string_literal: true

FactoryBot.define do
  factory(:user) do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    username { Faker::Name.name }
  end

  factory(:plant) do
    description { Faker::Lorem.sentence }
    name { Faker::Lorem.word }
    climate { 'Sunnytime' }
    latin { 'Aeschynanthus lobianus' }
    category { 'Hanging' }
    ideallight { 'Bright light' }
    watering { 'Keep moist between watering. Can be a bit dry between watering' }
  end

  factory(:comment) do
    body { Faker::Lorem.sentence(word_count: 7) }
    commentable { nil }
    deleted_at { nil }
  end
end
