require 'rails_helper'

RSpec.describe 'foods/index', type: :view do
  before(:each) do
    assign(:foods, [
             Food.create!(
               name: 'Name',
               meaurement_unit: 'Meaurement Unit',
               price: '9.99',
               quantity: '9.99',
               user: nil
             ),
             Food.create!(
               name: 'Name',
               meaurement_unit: 'Meaurement Unit',
               price: '9.99',
               quantity: '9.99',
               user: nil
             )
           ])
  end

  it 'renders a list of foods' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new('Name'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Meaurement Unit'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('9.99'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('9.99'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
