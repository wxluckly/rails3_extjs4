# coding: utf-8
module ImagesHelper
  def gundam_image(gundam, tp)
    raw image_tag(gundam.avatar.try(tp).url || GundamAvatarUploader::DEFAULT_URL)
  end
end