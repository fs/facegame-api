require "image_processing/mini_magick"

class QuestionImageUploader < Shrine
  ALLOWED_MIME_TYPES = %w[image/jpeg image/png image/webp].freeze

  Attacher.validate do
    validate_mime_type ALLOWED_MIME_TYPES
  end

  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)
    {
      normal: magick.resize_to_fit!(nil, 400),
      small: magick.resize_to_fit!(nil, 100)
    }
  end

  def generate_location(io, record: nil, derivative: nil, **options)
    options[:key]&.split("/")&.last || super
  end
end
