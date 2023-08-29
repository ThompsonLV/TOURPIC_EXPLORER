class QuestionsController < ApplicationController

  def show
    @monument = Monument.find(params[:monument_id])
    @question = Question.find(monument_id: @monument.id)
  end
end
