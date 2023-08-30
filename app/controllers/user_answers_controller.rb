class UserAnswersController < ApplicationController
  def create
    user_answer = UserAnswer.new(user_answer_params)
    user_answer.save
    monument  = Monument.find(params[:monument_id])
    questions = monument.questions
    answered_questions_ids = current_user.answers.where(question_id: questions.pluck(:id)).pluck(:question_id)
    unanswered_questions = questions.where.not(id: answered_questions_ids)

    question = unanswered_questions.first

    respond_to do |format|
      format.html
      format.text { "" }
    end
  end

  private

  def user_answer_params
    params.require(:user_answer).permit(:answer_id)
  end

end
