require 'faraday'

class Policy < ApplicationRecord
  belongs_to :airline
  has_many :favorites, dependent: :destroy

  has_neighbors :embedding
  after_create :set_embedding

  private

  def set_embedding
    client = OpenAI::Client.new
    max_retries = 5
    retries = 0

    begin
      # Rails.logger.info("Setting embedding for policy ID: #{id}, Title: #{title}")
      response = client.embeddings(
        parameters: {
          model: 'text-embedding-3-small',
          input: "Policy Title: #{title}. Category: #{category}. Airline Name: #{airline.name}. Policy Content: #{content}"
        }
      )
      embedding = response['data'][0]['embedding']
      update(embedding: embedding)
      # Rails.logger.info("Successfully set embedding for policy ID: #{id}, Title: #{title}")
    rescue Faraday::TooManyRequestsError => e
      if retries < max_retries
        retries += 1
        sleep_time = case retries
                    when 1 then 40
                    when 2 then 80
                    when 3 then 120
                    else 120 # Keep the sleep time at 120 seconds for retries 4 and 5
                    end
        puts "Rate limit exceeded for policy ID: #{id}, Title: #{title}. Retrying in #{sleep_time} seconds..."
        sleep(sleep_time)
        retry
      else
        puts "Rate limit exceeded for policy ID: #{id}, Title: #{title}. Max retries reached. Skipping..."
        raise
      end
    end
  end
end
