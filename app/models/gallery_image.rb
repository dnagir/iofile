class GalleryImage < ActiveRecord::Base
  mount_uploader :image, ImageUploader
end
