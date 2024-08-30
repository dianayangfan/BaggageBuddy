class Policy < ApplicationRecord
  belongs_to :airline
  has_many :favorites, dependent: :destroy
end
