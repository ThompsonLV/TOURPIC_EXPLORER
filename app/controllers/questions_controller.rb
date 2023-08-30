class QuestionsController < ApplicationController
  before_action :set_monument, only: :show

  def index
    @monument            = Monument.find(params[:monument_id])
    @number_of_questions = @monument.questions.count
    @question            = @monument.questions.first if @monument
  end
end
