class User < ApplicationRecord
  include ImageUploader::Attachment(:avatar)

  has_secure_password
  has_secure_token :password_reset_token

  has_many :activities, dependent: :destroy
  has_many :refresh_tokens, dependent: :destroy
  has_many :results, dependent: :destroy

  has_one :last_result, -> { order(created_at: :desc) }, class_name: "Result", inverse_of: :user

  validates :last_score, presence: true
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def full_name
    [first_name, last_name].compact.join(" ")
  end
end
