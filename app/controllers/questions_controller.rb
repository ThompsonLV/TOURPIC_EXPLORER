class QuestionsController < ApplicationController
  before_action :set_monument, only: :show

  def index
    @monument = Monument.find(params[:monument_id])
    if @monument
      @questions = @monument.questions
    end
    @question = Question.new
  end
end
