class Goods < ActiveRecord::Base
  geocoded_by :address
  after_validation :geocode

  def self.all_goods
    Goods.where.not(name: nil, latitude: nil, longitude: nil)
  end

  def self.explore_goods(lat, long, sort)
    goods = Goods.where.not(name: nil, latitude: nil, longitude: nil).order(sort)
    explore = {
      'goods': []
    }
    lat = lat.to_f
    long = long.to_f

    goods.each do |good|

      lats = []
      longs = []
      if !good.latitude.nil? && !good.longitude.nil?
        lats.append(good.latitude)
        longs.append(good.longitude)
      end
      if !good.latitude1.nil? && !good.longitude1.nil?
        lats.append(good.latitude1)
        longs.append(good.longitude1)
      end
      if !good.latitude2.nil? && !good.longitude2.nil?
        lats.append(good.latitude2)
        longs.append(good.longitude2)
      end

      lats.length.each do |i|
        lat_diff = (lat - lats[i]) * 3.1415926 / 180.0
        lng_diff = (long - longs[i]) * 3.1415926 / 180.0
        lat_sin = Math.sin(lat_diff / 2.0) ** 2
        lng_sin = Math.sin(lng_diff / 2.0) ** 2
        first = Math.sqrt(lat_sin + Math.cos(lat * 3.1415926 / 180.0) * Math.cos(lats[i] * 3.1415926 / 180.0) * lng_sin)
        result = Math.asin(first) * 2 * 6378137.0
        puts result.to_i
        next unless result.to_i < 1000

        unless explore.key?(good)
          explore[good] = {
            'lats': [],
            'longs': []
          }
        end

        explore[good]['lats'].append(lats[i])
        explore[good]['longs'].append(longs[i])


        # explore.append(good) if result.to_i < 1000
      end
    end

    explore
  end
end

