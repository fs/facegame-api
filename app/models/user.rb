class User < ApplicationRecord
  include ImageUploader::Attachment(:avatar)

  ALLOWED_EMAIL_SUBDOMAINS = ["flatstack.com", "flatstack.dev", "scalewill.com", "launchpad-kazan.com"].freeze

  has_secure_password
  has_secure_token :password_reset_token

  has_many :refresh_tokens, dependent: :destroy
  has_many :results, dependent: :destroy

  has_one :last_result, -> { finished.order(finish_at: :desc) }, class_name: "Result", inverse_of: :user

  validates :last_score, presence: true
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validate :check_email_subdomain

  def full_name
    [first_name, last_name].compact.join(" ")
  end

  private

  def check_email_subdomain
    return if email.split("@").last.in?(ALLOWED_EMAIL_SUBDOMAINS)

    errors.add(:email, "should have allowed subdomain")
  end
end
