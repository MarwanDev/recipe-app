FactoryBot.define do
  factory :food do
    # sequence(:email) { |n| "food_#{n}@example.com" }
    sequence(:name) { |n| "Banana #{n}" }
    meaurement_unit { 'piece' }
    price { 2.00 }
    association :user
  end
end
