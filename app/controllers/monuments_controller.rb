class MonumentsController < ApplicationController
  before_action :set_user, only: %i[]
  before_action :set_monument, only: %i[show map]

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
    @markers = [
      {
        lat: @monument.latitude,
        lng: @monument.longitude,
        info_window: render_to_string(partial: "info_window", locals: {monument: @monument}),
      }
    ]
    @unlocked_monument = UserMonument.where(monument_id: @monument.id, user_id: current_user.id).any?
    @nearest_monuments = Monument.where.not(id: @monument.id)
                                 .near([@monument.latitude, @monument.longitude], 1)
  end

  def map
    @coords = [@monument.longitude, @monument.latitude]
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
