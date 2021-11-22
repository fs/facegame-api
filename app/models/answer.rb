class Answer < ApplicationRecord
  belongs_to :result
  belongs_to :question

  validates :result, :question, presence: true

  scope :correct, -> { where(correct: true) }
  scope :answered, -> { where.not(value: nil) }
  scope :last_week, -> { where("created_at > ?", 1.week.ago.beginning_of_day) }
end
