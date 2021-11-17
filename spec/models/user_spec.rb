require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    User.create(email: "test@gmail.com", address: "nyc", first_name: "aa", last_name: "bb", username: "lol", password: "123456", password_confirmation: "123456")
    Goods.create(name: "Apple Watch", address: "1047 Amsterdam Ave, New York, NY 10025", user_name: "lol")
    Goods.create(name: "Textbooks", address: "2389 Broadway, New York, NY 10024", user_name: "lol")
  end

  after(:all) do
    User.destroy_all
    Goods.destroy_all
  end

  it 'should return correct record when we query by username' do
    user = User.get_user_by_username("lol")
    expect(user.address).eql? "nyc"
    expect(user.first_name).eql? "aa"
    expect(user.last_name).eql? "bb"
  end

  it 'should retrieve all goods posted by the user we specified' do
    goods = User.get_goods_of_user("lol")
    expect(goods[0].name).eql? "Apple Watch"
    expect(goods[1].name).eql? "Textbooks"
  end
end
