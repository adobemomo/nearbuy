require 'rails_helper'

RSpec.describe Goods, type: :model do
  before(:all) do
    Goods.create(name: 'Switch', address: '2389 Broadway, New York, NY 10024') if Goods.where(name: 'Switch').empty?

    Goods.create(name: 'Apple', address: '2880 Broadway, New York, NY 10025') if Goods.where(name: 'Apple').empty?
  end

  describe 'all_goods method' do
    it 'returns all goods' do
      goods = Goods.all_goods
      expect(goods.length).to eq 2
    end
  end

  after(:all) do
    Goods.destroy_all
  end
end
