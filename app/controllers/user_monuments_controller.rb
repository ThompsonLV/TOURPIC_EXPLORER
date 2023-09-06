class UserMonumentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  def create
    photo = params[:photo]
    @user_monument = UserMonument.new
    @user_monument.user = current_user
    @user_monument.monument = Monument.find(params[:monument_id])
    @user_monument.photos.attach(io: photo, filename: 'captured_image.png', content_type: 'image/png')
    @user_monument.save!

    new_score = current_user.score + @user_monument.monument.points
    current_user.update!(score: new_score)
  end

  def update
    @user_monument = UserMonument.find(params[:id])
    @user_monument.update(favoris: true)
  end

  private

  def user_monument_params
    params.require(:user_monument).permit(:favoris)
  end
end
