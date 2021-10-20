class QuestionImageUploader < Shrine
  ALLOWED_MIME_TYPES = %w[image/jpeg image/png image/webp].freeze

  Attacher.validate do
    validate_mime_type ALLOWED_MIME_TYPES
  end

  def generate_location(io, record: nil, derivative: nil, **options)
    options[:key]&.split("/")&.last || super
  end
end
