require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    User.create(email: "test@gmail.com", address: "nyc", first_name: "aa", last_name: "bb", username: "lol", password: "123456", password_confirmation: "123456")
  end

  after(:all) do
    User.destroy_all
  end

  it 'should return correct record when we query by username' do
    user = User.get_user_by_username("lol")
    expect(user.address).eql? "nyc"
    expect(user.first_name).eql? "aa"
    expect(user.last_name).eql? "bb"
  end
end
