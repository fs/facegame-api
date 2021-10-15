class Answer < ApplicationRecord
  belongs_to :result
  belongs_to :question

  validates :result, :question, :value, presence: true

  scope :correct, -> { where(correct: true) }
end
