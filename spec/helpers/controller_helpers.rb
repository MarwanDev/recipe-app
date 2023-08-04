# spec/support/controller_helpers.rb
module ControllerHelpers
  def sign_in_user
    @request.env['devise.mapping'] = Devise.mappings[:user]
    user = create(:user) # Create a test user
    sign_in user
  end
end
