require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!

RSpec.describe UsersController, type: :controller do
  include Devise::Test::IntegrationHelpers
  include Devise::Test::ControllerHelpers

  before(:all) do
    User.create(email: "test@gmail.com", address: "nyc", first_name: "aa", last_name: "bb", username: "lol", password: "123456", password_confirmation: "123456")
    user = User.new(email: "test@gmail.com", password: "123456")
    RSpec::Mocks.with_temporary_scope do
      allow(controller).to receive(:current_user).and_return(user)
    end
  end

  describe 'profile' do
    it 'should display the profile for the specified user' do
      user = User.get_user_by_username("lol")
      get :profile, username: user.username
      expect(response.response_code).to eq(302)
    end
  end

  after(:all) do
    User.destroy_all
  end
end