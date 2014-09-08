# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  def public_id
    no_extension = File.basename(original_filename, '.*')
    "my-files/#{no_extension}"
  end
end
