class QuestionsController < ApplicationController
  before_action :set_monument, only: :show

  def show
    @question = Question.find(monument_id: @monument.id)
  end

  # private

  # def set_monument
  #   @monument = Monument.find(params[:monument_id])
  # end

end
