require 'rails_helper'

RSpec.describe GoodsController, type: :controller do
  before(:all) do
    Goods.create(name: 'Switch', address: '2389 Broadway, New York, NY 10024') if Goods.where(name: 'Switch').empty?

    Goods.create(name: 'Apple', address: '2880 Broadway, New York, NY 10025') if Goods.where(name: 'Apple').empty?
  end

  describe 'index' do
    it 'show goods' do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe 'creates' do
    it 'goods with valid parameters' do
      get :create, {goods: {name: 'Macbook Pro',
                            address: '2380 Broadway, New York, NY 10024'}}
      expect(response).to redirect_to goods_path
      expect(flash[:notice]).to match(/Macbook Pro was successfully created./)
      Goods.find_by(name: 'Macbook Pro').destroy
    end
  end

  describe 'updates' do
    it 'update goods' do
      good = Goods.create(name: 'PS5',
                          address: '2480 Broadway, New York, NY 10024')
      patch :update, {id: good.id, goods:         {address: '2389 Broadway, New York, NY 10024'}
      }

      expect(response).to redirect_to good_path(good)
      expect(Goods.find_by(id: good.id).address).to match(/2389 Broadway, New York, NY 10024/)
      expect(flash[:notice]).to match(/Goods was successfully updated./)
      good.destroy
    end
  end

  describe 'destroys' do
    it 'destroy goods' do
      good = Goods.create(name: 'PS4',
                          address: '2480 Broadway, New York, NY 10024')
      delete :destroy, {
        id: good.id
      }

      expect(response).to redirect_to goods_path
      expect(Goods.find_by(id: good.id).nil?).to be true

    end
  end

  describe 'news' do
    it 'new goods' do
      # good = Goods.create(name: "PSP",
      #                     address: "2480 Broadway, New York, NY 10024")
      get :new

      expect(response).to have_http_status(200)

    end
  end


end
