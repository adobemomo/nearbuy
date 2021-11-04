class Goods < ActiveRecord::Base
  geocoded_by :address
  after_validation :geocode

  def self.all_goods
    Goods.where.not(name: nil, latitude: nil, longitude: nil)
  end

end
