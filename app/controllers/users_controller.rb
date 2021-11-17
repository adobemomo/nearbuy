class UsersController < ApplicationController
  before_action :authenticate_user!

  def profile
    redirect_to(root_path) unless user_signed_in?
    @user = current_user
  end
  
end
