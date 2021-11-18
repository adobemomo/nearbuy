require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!

RSpec.describe UsersController, type: :controller do
  include Devise::Test::IntegrationHelpers
  include Devise::Test::ControllerHelpers

  before(:all) do
    User.create(email: "test@gmail.com", address: "nyc", first_name: "sheng", last_name: "jiang", username: "sjiang", password: "123456", password_confirmation: "123456")
    Goods.create(user_name: "sjiang", name: "apple watch")
    Goods.create(user_name: "anony", name: "nintendo switch")
  end

  before(:each) do
    user = User.find_by(email: 'test@gmail.com')
    allow(controller).to receive(:current_user).and_return(user)
    allow(controller).to receive(:authenticate_user!).and_return(true)
  end

  describe 'profile' do
    it 'should display the profile for the specified user' do
      user = User.get_user_by_username("sjiang")
      get :profile, username: user.username
      expect(response.response_code).to eq(200)
    end
  end

  describe 'goods list' do
    it 'should display the goods sold by the current user' do
      get :goods_list
      expect(response.response_code).to eq(200)
    end

    it 'should support deleting goods' do
      good = Goods.find_by(name: "apple watch")
      delete :delete_good, id: good.id
      expect(response).to redirect_to user_goods_list_path
      expect(Goods.find_by(name: "apple watch").nil?).to be true
    end
  end

  after(:all) do
    User.destroy_all
  end
end