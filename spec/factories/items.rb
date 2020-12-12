require 'faker'

FactoryBot.define do
  factory :item do
    name { Faker::Name.unique.name }
    description { Faker::Lorem.sentence }
    unit_price { Faker::Commerce.price }
    merchant
  end
end
