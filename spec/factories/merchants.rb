require 'faker'

FactoryBot.define do
  factory :merchant do
    name { Faker::GreekPhilosophers.name  }
  end
end
