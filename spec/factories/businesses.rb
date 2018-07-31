FactoryBot.define do
  factory :business do
    sequence(:name) { |n| "#{Faker::Company.unique.name}_#{n}" }
    categories { [create(:category)] }
    locations { [create(:location)] }
  end
end
