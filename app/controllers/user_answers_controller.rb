class UserAnswersController < ApplicationController
  def create
    user_answer = UserAnswer.new(user_answer_params)
    user_answer.save
  end

  private

  def user_answer_params
    params.require(:user_answer).permit(:answer_id)
  end

end
