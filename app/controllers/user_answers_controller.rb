class UserAnswersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    user_answer = UserAnswer.new(user_answer_params)
    user_answer.user = current_user
    user_answer.save
    monument = user_answer.answer.question.monument

    questions = monument.questions.where.not(id: params[:user_answer][:questions].split(","))

    question = questions.first
    p question

    respond_to do |format|
      format.html
      format.text { render partial: "questions/form_quizz", locals: { question: }, formats: :html }
    end
  end

  private

  def user_answer_params
    params.require(:user_answer).permit(:answer_id)
  end
end
