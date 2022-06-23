class Post < ApplicationRecord

  belongs_to :customer
  #カテゴリー機能
  belongs_to :category
  #いいね機能
  has_many :favorites, dependent: :destroy
  #コメント機能
  has_many :post_comments, dependent: :destroy

  # ハッシュタグ機能
  has_many :post_hashtag_relations, dependent: :destroy
  # post_hashtag_relationを経由してhashtagへ
  has_many :hashtags, through: :post_hashtag_relations


  # ソート機能
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :star_count, -> {order(rate: :desc)}

  # ハッシュタグ機能
  after_create do
    post = Post.find_by(id: id)
    hashtags  = introduction.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    post.hashtags = []
    hashtags.uniq.map do |hashtag|
      #ハッシュタグは先頭の'#'を外した上で保存
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      post.hashtags << tag
    end
  end

  before_update do
    post = Post.find_by(id: id)
    # 重複のことも考え、一度ハッシュタグを消した上で、保存する
    post.hashtags.clear
    hashtags = introduction.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      post.hashtags << tag
    end
  end


  # レビューの星マークの設定 数値のみを許可する為numericalityを使用 1～5までとする
  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 0.5}, presence: true


  has_one_attached :image

  # 会員の投稿画像をアップロード
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

  #キーワード検索機能
  def self.search_for(content, method)
    # 検索バーの記述　"完全一致"=>"perfect","部分一致"=>"partial"
    if method == 'perfect'
      # 完全一致
      Post.where(title: content)
    else
      # 部分一致　'%'+content+'%'
      Post.where('title LIKE ?', '%'+content+'%')
    end
  end

end
