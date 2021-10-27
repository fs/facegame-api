class Answer < ApplicationRecord
  belongs_to :result
  belongs_to :question

  validates :result, :question, :value, presence: true

  scope :correct, -> { where(correct: true) }
  scope :last_week, -> { where("created_at > ?", 1.week.ago.beginning_of_day) }
end
