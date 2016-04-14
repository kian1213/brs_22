class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include Cloudinary::CarrierWave

  process convert: "jpg"

  version :thumbnail do
    eager
    resize_to_fit(150, 150)
    cloudinary_transformation quality: 80
  end
end

