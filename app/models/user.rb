class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.get_user_by_username(username)
    User.find_by(username: username)
  end

  def self.get_goods_of_user(username)
    Goods.where(user_name: username).to_a
  end
end
