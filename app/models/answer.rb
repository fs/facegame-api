class Answer < ApplicationRecord
  belongs_to :result
  belongs_to :question

  validates :result, :question, :value, :correct, presence: true
end
