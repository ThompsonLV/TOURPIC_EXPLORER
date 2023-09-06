class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def my_profil
    @user      = current_user
    @monuments = Monument.all
    @users = User.all.sort_by { |u| -u.user_monuments.count }
  end

  def parameters
    @user = current_user
  end
end
