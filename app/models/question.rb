class Question < ApplicationRecord
  belongs_to :user
  # Chatbot
  has_neighbors :embedding
  validates :user_question, presence: true
  after_create :fetch_ai_answer
  # after_create :set_embedding

  private

  def fetch_ai_answer
    ChatbotJob.perform_later(self)
  end

  def set_embedding
    client = OpenAI::Client.new
    begin
      response = client.embeddings(
        parameters: {
          model: "text-davinci-003",
          input: "Policy Question: #{user_question}"
        }
      )
      if response && response['data'] && response['data'][0] && response['data'][0]['embedding']
        embedding = response['data'][0]['embedding']
        update(embedding: embedding)
      else
        Rails.logger.error("Failed to fetch embedding: #{response}")
      end
    rescue OpenAI::Error => e
      Rails.logger.error("OpenAI API error: #{e.message}")
    rescue StandardError => e
      Rails.logger.error("Unexpected error: #{e.message}")
    end
  end
end
