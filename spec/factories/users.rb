# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    # Define user attributes here
    name { 'User One' }
    email { 'userone@example.com' }
    password { 'useronepassword123' }
  end
end
