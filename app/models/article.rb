class Article < ApplicationRecord

  has_one_attached :image

  def get_image(size)
     unless image.attached?
      file_path = Rails.root.join('app/assets/images/no-photo.jpg')
      image.attach(io: File.open(file_path), filename: 'default-photo.jpg', content_type: 'image/jpeg')
     end
     image.variant(resize:size).processed
  end

end
