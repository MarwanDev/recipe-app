require 'rails_helper'
require 'faker'

RSpec.describe Recipe, type: :model do
  let(:specialuser) do
    User.create!(name: Faker::Name.unique.name,
                 email: Faker::Internet.email,
                 password: 'fakepassword', password_confirmation: 'fakepassword')
  end

  subject do
    Recipe.new(
      name: 'Camel meat',
      preparation_time: '4 hours',
      cooking_time: '8 hours',
      description: 'Yummy recipe',
      public: false,
      user: specialuser
    )
  end

  before { subject.save }

  it 'should have a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'should have a Description' do
    subject.description = nil
    expect(subject).to_not be_valid
  end

  it 'should save properly' do
    expect(subject).to be_valid
  end
end
