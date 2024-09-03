class ChatbotJob < ApplicationJob
  queue_as :default

  def perform(question)
    @question = question
    begin
      chatgpt_response = client.chat(
        parameters: {
          model: "gpt-3.5-turbo",
          messages: questions_formatted_for_openai
        }
      )
      new_content = chatgpt_response["choices"][0]["message"]["content"]
      question.update(ai_answer: new_content)
      Turbo::StreamsChannel.broadcast_update_to(
        "question_#{question.id}",
        target: "question_#{question.id}",
        partial: "questions/question", locals: { question: question }
      )
    rescue StandardError => e
      Rails.logger.error("OpenAI API error: #{e.message}")
    end
  end

  private

  def client
    @client ||= OpenAI::Client.new
  end

  def questions_formatted_for_openai
    questions = @question.user.questions
    results = []
    system_text = "You are a chatbot assisting users on a airline policy website named BaggageBuddy. If you don't know the answer to a question you can say I don't know. Here are the polices you can use to answer the user's questions"

    nearest_policies.each do |policy|
      system_text += "** POLICY: #{policy.id} ** Policy Title: #{policy.title}. Category: #{policy.category}. Airline Name: #{policy.airline.name}. Policy Content: #{policy.content} \n"
    end

    results << { role: "system", content: system_text }

    questions.each do |question|
      results << { role: "user", content: question.user_question }
      results << { role: "assistant", content: question.ai_answer || "" }
    end

    return results
  end

  def nearest_policies
    response = client.embeddings(
      parameters: {
        model: 'text-embedding-3-small',
        input: @question.user_question
      }
    )
    question_embedding = response['data'][0]['embedding']
    return Policy.nearest_neighbors(
      :embedding, question_embedding,
      distance: "euclidean"
    ).first(3) # you may want to add .first(3) here to limit the number of results
  end
end
