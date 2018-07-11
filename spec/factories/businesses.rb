FactoryBot.define do
  factory :business do
    name Faker::Company.unique.name
  end
end
