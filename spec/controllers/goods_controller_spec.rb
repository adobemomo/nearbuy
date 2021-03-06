require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!

RSpec.describe GoodsController, type: :controller do
  include Devise::Test::IntegrationHelpers
  include Devise::Test::ControllerHelpers

  before(:all) do
    Goods.create(name: 'Switch', address: '2389 Broadway, New York, NY 10024') if Goods.where(name: 'Switch').empty?
    Goods.create(name: 'Apple', address: '2880 Broadway, New York, NY 10025') if Goods.where(name: 'Apple').empty?
    Goods.create(name: "Apple Watch", address: "1047 Amsterdam Ave, New York, NY 10025", user_name: "lol", description: "apple watch series 7, 99% new")
    Goods.create(name: "Textbooks", address: "2389 Broadway, New York, NY 10024", user_name: "lol", description: "Calculus")
    Goods.create(name: "Desktop table", address: "2393 Broadway, New York, NY 10024", user_name: "lol", description: "good")
    Goods.create(name: "nintendo switch", address: "2396 Broadway, New York, NY 10024", user_name: "lol", description: "cool")
    Goods.create(name: "chair", address: "2400 Broadway, New York, NY 10024", user_name: "lol", description: "great")
    Goods.create(name: "pot", address: "2404 Broadway, New York, NY 10024", address1: "2408 Broadway, New York, NY 10024", latitude1: 40.47, longitude1: -73.58, address2: "2412 Broadway, New York, NY 10024", latitude2: 40.48, longitude2: -73.59, user_name: "lol", description: "excellent")
    User.create(email: 'test@gmail.com', address: 'nyc', first_name: 'aa', last_name: 'bb', username: 'lol', password: '123456', password_confirmation: '123456')
  end

  before(:each) do
    user = User.find_by(email: 'test@gmail.com')
    allow(controller).to receive(:current_user).and_return(user)
    allow(controller).to receive(:authenticate_user!).and_return(true)
  end

  after(:all) do
    Goods.destroy_all
    User.destroy_all
  end

  describe 'index' do
    it 'show goods' do
      get :index
      expect(response).to have_http_status(200)
    end
    it 'show goods when session needs update' do
      request.session[:sort] = 'update_time'
      get :index, {params: {sort: 'name', clear: 'clear'}}
      expect(response).to redirect_to goods_path(sort: 'name')
    end
    it 'show goods order by update time' do
      get :index, {params: {sort: 'update_time'}}

      ordered_goods = @controller.instance_variable_get(:@goods)
      expect(ordered_goods[0].name).to eq 'pot'
      expect(ordered_goods[1].name).to eq 'chair'
      expect(ordered_goods[ordered_goods.length - 1].name).to eq 'Switch'

    end
    it 'explore mode' do
      get :index, {params: {latitude: 40.7909156, longitude: -73.9726773}}

      explored_goods = @controller.instance_variable_get(:@goods)
      # explored_goods.each do |good|
      #   puts good.name
      # end
      expect(explored_goods.length).to eq 6
      expect(explored_goods[0].name).to eq 'Switch'
    end
  end

  describe 'creates' do
    it 'goods with valid parameters' do
      post :create, { goods: { name: 'Macbook Pro',
                               address: '2380 Broadway, New York, NY 10024',
                               address1: '2381 Broadway, New York, NY 10024',
                               address2: '2382 Broadway, New York, NY 10024'} }
      expect(response).to redirect_to user_goods_list_path
      expect(flash[:notice]).to match(/Macbook Pro was successfully created./)
      good = Goods.find_by(name: 'Macbook Pro')
      user = User.find_by(email: 'test@gmail.com')
      expect(good.address).to eq '2380 Broadway, New York, NY 10024'
      expect(good.address1).to eq '2381 Broadway, New York, NY 10024'
      expect(good.address2).to eq '2382 Broadway, New York, NY 10024'
      expect(good.user_name).to eq user.username
      good.destroy
    end
    it 'goods create failed' do
      mock = double('goods', save: false)
      expect(Goods).to receive(:new).and_return(mock)
      post :create, { goods: { name: 'Macbook Pro',
                               address: '2380 Broadway, New York, NY 10024' } }
      expect(response.status).to eq 200
      expect(Goods.find_by(name: 'Macbook Pro').nil?).to be true

    end
  end

  describe 'updates' do
    it 'update goods' do
      good = Goods.create(name: 'PS5',
                          address: '2480 Broadway, New York, NY 10024')
      patch :update, { id: good.id, goods:         { address: '2389 Broadway, New York, NY 10024',
                                                     address1: '2390 Broadway, New York, NY 10024',
                                                     address2: '2391 Broadway, New York, NY 10024' }
      }

      expect(response).to redirect_to user_goods_list_path
      expect(Goods.find_by(id: good.id).address).to match(/2389 Broadway, New York, NY 10024/)
      expect(Goods.find_by(id: good.id).address1).to match(/2390 Broadway, New York, NY 10024/)
      expect(Goods.find_by(id: good.id).address2).to match(/2391 Broadway, New York, NY 10024/)
      expect(flash[:notice]).to match(/Goods was successfully updated./)
      good.destroy
    end
    it 'goods update failed' do
      mock = double('goods', update: false)
      expect(Goods).to receive(:find).and_return(mock)
      good = Goods.create(name: 'PS5',
                          address: '2480 Broadway, New York, NY 10024')
      patch :update, { id: good.id, goods:         { address: '2389 Broadway, New York, NY 10024' }
      }
      expect(response.status).to eq 200
      expect(Goods.find_by(id: good.id).address).to match(/2480 Broadway, New York, NY 10024/)
      good.destroy
    end
  end

  # describe 'destroys' do
  #   it 'destroy goods' do
  #     good = Goods.create(name: 'PS4',
  #                         address: '2480 Broadway, New York, NY 10024')
  #     delete :destroy, {
  #       id: good.id
  #     }
  #
  #     expect(response).to redirect_to goods_path
  #     expect(Goods.find_by(id: good.id).nil?).to be true
  #
  #   end
  #   it 'destroy goods failed' do
  #     mock = double('goods', destroy: false)
  #     expect(Goods).to receive(:find).and_return(mock)
  #     good = Goods.create(name: 'PS4',
  #                         address: '2480 Broadway, New York, NY 10024')
  #     delete :destroy, {
  #       id: good.id
  #     }
  #
  #     expect(response).to redirect_to goods_path
  #     expect(Goods.find_by(id: good.id).nil?).to be false
  #     good.destroy
  #
  #   end
  # end

  describe 'news' do
    it 'new goods' do
      # good = Goods.create(name: "PSP",
      #                     address: "2480 Broadway, New York, NY 10024")
      get :new

      expect(response).to have_http_status(200)

    end
  end


end
