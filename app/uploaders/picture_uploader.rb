class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file
  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*args)
    "/images/" + [version_name, "default.png"].compact.join('_')
  end

  version :thumb400 do
    process resize_and_pad(400, 400, background = :transparent, gravity = 'Center')
  end

  def extension_whitelist
    %w(jpg jpeg png)
  end
end
