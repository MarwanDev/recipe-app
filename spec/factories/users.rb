# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    # Define user attributes here
    name { "John Doe" }
    email { "john.doe@example.com" }
    password { "password123" }
  end
end
