class QuestionsController < ApplicationController
  # Chatbot
  def index
    @questions = current_user.questions
    @question = Question.new # for the form
  end

  # def new
  #   @question = Question.new
  # end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      respond_to do |format|
        format.html { redirect_to questions_path, notice: 'Question was successfully created.' }
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(:questions, partial: 'questions/question', locals: { question: @question })
        end
      end
    else
      respond_to do |format|
        format.html { render :index, status: :unprocessable_entity }
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(:question_form, partial: 'questions/form', locals: { question: @question })
        end
      end
    end
  end

  def question_params
    params.require(:question).permit(:user_question, :description)
  end
end
