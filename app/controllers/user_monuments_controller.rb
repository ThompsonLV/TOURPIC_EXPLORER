class UserMonumentsController < ApplicationController
  def create
    @user_monument = UserMonument.new(user_monument_params)
    @user_monument.user = current_user
    @user_monument.monument = Monument.find(params[:id])
    @user_monument.save
    redirect_to my_profil_path
  end

  private

  def user_monument_params
    params.require(:user_monument).permit(:favoris)
  end
end
