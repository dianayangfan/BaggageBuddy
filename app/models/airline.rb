class Airline < ApplicationRecord
  has_one_attached :logo
  has_many :policies
end
