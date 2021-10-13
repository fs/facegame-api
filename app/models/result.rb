class Result < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy

  validates :user, :score, presence: true
end
