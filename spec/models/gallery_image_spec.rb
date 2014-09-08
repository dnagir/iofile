require 'spec_helper'

class SmallestFile < StringIO
  attr_reader :original_filename # requried by CarrierWave

  def initialize(fn)
    super(smallest_image)
    @original_filename = fn
  end

  private

  def smallest_image
    Base64.decode64('R0lGODlhAQABAIAAAP///wAAACwAAAAAAQABAAACAkQBADs=')
  end
end



describe GalleryImage do
  it 'describes the issue for cloudinary where I cannot use IO object (StringIO derrived)' do
    # raises
    # CloudinaryException: Unsupported source URL: #<Factories::SmallestFile:0x007fab877d1e70>
    # from /Users/dnagir/.rvm/gems/ruby-2.1.2-railsexpress/gems/cloudinary-1.0.75/lib/cloudinary/uploader.rb:297:in `block in call_api'
    result = Cloudinary::Uploader.upload(SmallestFile.new('file-1.gif'))
    result['public_id'].should be_present
  end

  it 'allows using IO with model' do
    io = SmallestFile.new('foo-1.gif')
    i = GalleryImage.create!(image: io)['image']
    i.should end_with 'my-files/foo-1.gif'
  end
end
