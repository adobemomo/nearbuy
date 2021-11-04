class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    @user = User.get_user_by_username(params[:username])
  end

end
