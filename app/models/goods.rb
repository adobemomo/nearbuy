class Goods < ActiveRecord::Base
  geocoded_by :address
  after_validation :geocode

  def self.all_goods
    Goods.where.not(name: nil, latitude: nil, longitude: nil)
  end

  def self.explore_goods(lat, long, sort)
    goods = Goods.where.not(name: nil, latitude: nil, longitude: nil).order(sort)
    explore = []
    lat = lat.to_f
    long = long.to_f

    puts 'lat', lat
    puts 'longititude', long

    goods.each do |good|
      lat_diff = (lat - good.latitude) * 3.1415926 / 180.0
      lng_diff = (long - good.longitude) * 3.1415926 / 180.0
      lat_sin = Math.sin(lat_diff / 2.0)**2
      lng_sin = Math.sin(lng_diff / 2.0)**2
      first = Math.sqrt(lat_sin + Math.cos(lat * 3.1415926 / 180.0) * Math.cos(good.latitude * 3.1415926 / 180.0) * lng_sin)
      result = Math.asin(first) * 2 * 6378137.0
      puts result.to_i
      explore.append(good) if result.to_i < 1000
    end

    explore
  end

end
