require 'rails_helper'

RSpec.describe 'foods/show', type: :view do
  before(:each) do
    assign(:food, Food.create!(
                    name: 'Name',
                    meaurement_unit: 'Meaurement Unit',
                    price: '9.99',
                    quantity: '9.99',
                    user: nil
                  ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Meaurement Unit/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(//)
  end
end
