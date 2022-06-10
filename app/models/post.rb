class Post < ApplicationRecord

  belongs_to :customer
  belongs_to :category
  has_many :favorites, dependent: :destroy

  has_one_attached :image

  #　会員の投稿画像をアップロード
  def get_image(size)
     unless image.attached?
      file_path = Rails.root.join('app/assets/images/no-photo.jpg')
      image.attach(io: File.open(file_path), filename: 'default-photo.jpg', content_type: 'image/jpg')
     end
     image.variant(resize:size).processed
  end

  #いいねしているかの確認
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

end
