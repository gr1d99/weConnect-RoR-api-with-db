FactoryBot.define do
  factory :business do
    name Faker::Company.unique.name
    categories { [create(:category)] }
    locations { [create(:location)] }
  end
end
