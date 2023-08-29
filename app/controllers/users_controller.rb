class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def my_profil
    @user = current_user
  end
end
