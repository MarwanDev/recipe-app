# spec/factories.rb
FactoryBot.define do
  factory :recipe do
    user # This will associate a user with the recipe.
    name { 'Test Recipe' }
    description { 'This is a test recipe.' }
    public { true }
    preparation_time { '30 minutes' } # Provide a valid preparation_time value
    cooking_time { '1 hour' } # Provide a valid cooking_time value
    created_at { Time.current }
    # Other attributes as needed
    association :recipe_food
  end
end
