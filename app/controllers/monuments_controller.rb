class MonumentsController < ApplicationController
  before_action :set_user, only: %i[]
  before_action :set_monument, only: %i[show]

  def index
    @monuments = Monument.all
    @markers = @monuments.geocoded.map do |monument|
      {
        lat: monument.latitude,
        lng: monument.longitude,
        info_window: render_to_string(partial: "info_window", locals: {monument: monument}),
      }
    end
  end

  def show
  end

  private

  def set_monument
    @monument = Monument.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  # def monument_params
  #   params.require(:monument).permit(:title, :short_description, :long_description, :points, :address, :photo)
  # end
end
