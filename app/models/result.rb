class Result < ApplicationRecord
  belongs_to :user
  has_many :answers

  validates :user, :score, :time_duration, presence: true
end
