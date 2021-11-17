class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    @user = User.get_user_by_username(params[:username])
  end

  def goods_list
    redirect_to(root_path) unless user_signed_in?
    @goods = User.get_goods_of_user(current_user.username)
  end

  def delete_good
    @good = Goods.find_by(params[:id])
    if @good.destroy
      redirect_to(user_goods_list_path)
    else
      respond_destroy_fail
    end
  end
end
