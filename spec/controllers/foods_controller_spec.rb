require 'rails_helper'

RSpec.describe FoodsController, type: :controller do
  let(:user) { create(:user) } 
  let(:food_params) { { food: { name: 'Pizza', measurement_unit: 'slice', price: 10, quantity: 2, user_id: user.id } } }

  describe 'GET #index' do
    it 'assigns @foods' do
      food = create(:food, user: user)
      get :index, params: { user_id: user.id }
      expect(assigns(:foods)).to eq([food])
    end

    it 'renders the index template' do
        sign_in user
        get :index, params: { user_id: user.id }
        expect(response).to render_template(:index)
      end
      
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new food' do
        expect {
          post :create, params: food_params
        }.to change(Food, :count).by(1)
      end

      it 'redirects to the user foods path' do
        post :create, params: food_params
        expect(response).to redirect_to(user_foods_path(user))
      end
    end

    context 'with invalid params' do
      it 'does not create a new food' do
        expect {
          post :create, params: { food: { name: '' } }
        }.not_to change(Food, :count)
      end

      it 'renders the new template with unprocessable_entity status' do
        post :create, params: { food: { name: '' } }
        expect(response).to render_template(:new)
        expect(response.status).to eq(422) # 422 is the status for unprocessable_entity
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:food) { create(:food, user: user) }

    it 'destroys the requested food' do
      expect {
        delete :destroy, params: { id: food.id }
      }.to change(Food, :count).by(-1)
    end

    it 'redirects to the user foods path' do
      delete :destroy, params: { id: food.id }
      expect(response).to redirect_to(user_foods_path(user))
    end
  end

  # You don't need to write tests for the `set_food` method and `food_params` method, as they are private and automatically tested when you test the public methods like `index`, `create`, and `destroy`.
end
