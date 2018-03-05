class ImageFormatTransformationService
  attr_accessor :image_blob, :format

  def whitelist
    %w(jpg jpeg png pdf bmp tif tiff)
  end

  def convert
    raise ArgumentError 'Image blob needs to be provided' unless image_blob
    raise ArgumentError 'Format needs to be provided' unless format
    raise ArgumentError 'The format is not allowed please use common image formats' unless whitelist.include?(format)
    image = MiniMagick::Image.read(image_blob)
    image.format(format)
    image.to_blob
  end

end