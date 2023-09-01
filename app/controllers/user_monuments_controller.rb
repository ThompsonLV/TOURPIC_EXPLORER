class UserMonumentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  def create
    @user_monument = UserMonument.new
    @user_monument.user = current_user
    @user_monument.monument = Monument.find(params[:monument_id])
    @user_monument.save
    render json: {
      toto: "lalal"
    }
  end

  private

  def user_monument_params
    params.require(:user_monument).permit(:favoris)
  end
end
