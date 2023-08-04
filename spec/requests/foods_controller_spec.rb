require 'rails_helper'

RSpec.describe FoodsController, type: :request do
  let(:user) { User.new(name: 'Mario', email: 'mario@mario.com', password: 'password') }
  let(:food) { Food.new(name: 'bala7', meaurement_unit: 'kgs', price: 700, quantity: 20, user:) }
  before do
    user.skip_confirmation!
    user.save
    post user_session_path, params: { user: { email: user.email, password: user.password } }
    follow_redirect!
    food.save
  end
  describe 'GET user#show' do
    it 'returns a successful response' do
      get user_path(user)
      expect(response).to be_successful
    end
  end

  describe 'GET food#index' do
    it 'returns a successful response' do
      get user_foods_path(user)
      expect(response).to be_successful
    end
  end
  describe 'POST food#new' do
    it 'returns a successful response' do
      get new_user_food_path(user)
      expect(response).to be_successful
    end
  end

  describe 'DELETE food#destroy' do
    it 'returns a successful response' do
      delete user_food_path(user, food)
      expect(response).to redirect_to(user_foods_url(user))
    end
  end
end
