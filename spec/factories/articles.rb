FactoryBot.define do
  factory :article do
    title { Faker::Lorem.characters(number: 20) }
    content { Faker::Lorem.characters(number: 300) }
  end
end
