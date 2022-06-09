class Post < ApplicationRecord

  belongs_to :customer
  belongs_to :category

  has_one_attached :image

  #　会員の投稿画像をアップロード
  def get_image(size)
     unless image.attached?
      file_path = Rails.root.join('app/assets/images/no-photo.jpg')
      image.attach(io: File.open(file_path), filename: 'default-photo.jpg', content_type: 'image/jpg')
     end
     image.variant(resize:size).processed
  end

end
