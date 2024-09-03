class Policy < ApplicationRecord
  belongs_to :airline
  has_many :favorites, dependent: :destroy

  has_neighbors :embedding
  after_create :set_embedding

  private

  def set_embedding
    client = OpenAI::Client.new
    max_retries = 3
    retries = 0

    begin
      response = client.embeddings(
        parameters: {
          model: 'text-embedding-3-small',
          input: "Policy Title: #{title}. Category: #{category}. Airline Name: #{airline.name}. Policy Content: #{content}"
        }
      )
      embedding = response['data'][0]['embedding']
      update(embedding: embedding)
    rescue Faraday::ClientError => e
      if e.response[:status] == 429 && retries < max_retries
        retries += 1
        sleep_time = (2 ** retries) * 5 # Exponential backoff: 5, 10, 20 seconds
        Rails.logger.warn("Rate limit exceeded. Retrying in #{sleep_time} seconds...")
        sleep(sleep_time)
        retry
      else
        Rails.logger.error("Failed to fetch embedding: #{e.message}")
        raise
      end
    end
  end
end
