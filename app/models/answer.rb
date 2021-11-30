class Answer < ApplicationRecord
  extend Enumerize

  AVALIABLE_STATUSES = %w[correct incorrect current pending].freeze

  belongs_to :result
  belongs_to :question

  validates :result, :question, presence: true
  enumerize :status, in: AVALIABLE_STATUSES, scope: :shallow, default: :pending

  scope :answered, -> { where(status: [:correct, :incorrect]) }
  scope :last_week, -> { where("created_at > ?", 1.week.ago.beginning_of_day) }
end
