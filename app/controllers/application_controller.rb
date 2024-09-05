class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_questions, if: :user_signed_in?

  private

  def set_questions
    @questions = current_user.questions
    @question = Question.new
  end
end
