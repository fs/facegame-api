class Question < ApplicationRecord
  include ImageUploader::Attachment(:avatar)

  validates :full_name, :department, presence: true
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
