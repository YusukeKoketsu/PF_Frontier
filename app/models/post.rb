class Post < ApplicationRecord

  belongs_to :customer
  #カテゴリー機能
  belongs_to :category
  #いいね機能
  has_many :favorites, dependent: :destroy
  #コメント機能
  has_many :post_comments, dependent: :destroy

  # レビューの星マークの設定　数値のみを許可する為numericalityを使用 1～5までとする
  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1}, presence: true



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
