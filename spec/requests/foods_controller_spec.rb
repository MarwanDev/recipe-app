require 'rails_helper'

RSpec.describe FoodsController, type: :controller do
  describe 'GET #index' do
    it 'assigns @foods' do
      user = create(:user) 
      food = create(:food, user: user)

      sign_in_user 

      get :index, params: { user_id: user.id }
      expect(assigns(:foods)).to eq([food])
    end

    it 'renders the index template' do
      sign_in_user # Sign in the user using the helper method

      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new food' do
        user = create(:user) # Create a test user

        sign_in_user # Sign in the user using the helper method

        expect do
          post :create,
               params: { food: { name: 'Pizza', measurement_unit: 'slice', price: 10, quantity: 2, user_id: user.id } }
        end.to change(Food, :count).by(1)
      end

      it 'redirects to the user foods path' do
        user = create(:user) # Create a test user

        sign_in_user # Sign in the user using the helper method

        post :create,
             params: { food: { name: 'Pizza', measurement_unit: 'slice', price: 10, quantity: 2, user_id: user.id } }
        expect(response).to redirect_to(user_foods_path(user))
      end
    end

    context 'with invalid params' do
      it 'does not create a new food' do
        user = create(:user) # Create a test user

        sign_in_user # Sign in the user using the helper method

        expect do
          post :create, params: { food: { name: '' } }
        end.not_to change(Food, :count)
      end

      it 'renders the new template with unprocessable_entity status' do
        user = create(:user) # Create a test user

        sign_in_user # Sign in the user using the helper method

        post :create, params: { food: { name: '' } }
        expect(response).to render_template(:new)
        expect(response.status).to eq(422) # 422 is the status for unprocessable_entity
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested food' do
      user = create(:user) # Create a test user
      food = create(:food, user: user) # Create a test food associated with the user

      sign_in_user # Sign in the user using the helper method

      expect do
        delete :destroy, params: { id: food.id }
      end.to change(Food, :count).by(-1)
    end

    it 'redirects to the user foods path' do
      user = create(:user) # Create a test user
      food = create(:food, user: user) # Create a test food associated with the user

      sign_in_user # Sign in the user using the helper method

      delete :destroy, params: { id: food.id }
      expect(response).to redirect_to(user_foods_path(user))
    end
  end
end
