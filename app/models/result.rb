class Result < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy

  validates :user, :score, presence: true

  scope :active, -> { where("finish_at > ?", Time.current) }
  scope :finished, -> { where("finish_at IS NULL OR finish_at < ?", Time.current) }
end
