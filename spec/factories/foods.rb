# spec/factories/foods.rb
FactoryBot.define do
    factory :food do
      name { "Apple" }
      measurement_unit { "grams" }
      price { 25.00 }
      quantity { 1 }
      user
    end
  end
  