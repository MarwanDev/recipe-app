FactoryBot.define do
  factory :recipe_food do
    quantity { 1 }
    association :food
    association :recipe
  end
end
