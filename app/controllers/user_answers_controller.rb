class UserAnswersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    user_answer = UserAnswer.new(user_answer_params)
    user_answer.user = current_user
    user_answer.save!

    monument = user_answer.answer.question.monument

    current_user.update(score: current_user.score + 5) if user_answer.answer.success?

    questions = monument.questions.where.not(id: params[:user_answer][:questions].split(","))
    counter = (monument.questions.count - questions.count) + 1
    question = questions.first

    respond_to do |format|
      format.html
      format.text { render partial: "questions/form_quizz", locals: { question:, monument:, counter: }, formats: :html }
    end
  end

  private

  def user_answer_params
    params.require(:user_answer).permit(:answer_id)
  end
end
