class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

# ゲストログイン機能
def self.guest
    find_or_create_by!(last_name: 'guest', first_name: 'Login', last_name_kana: 'guest', first_name_kana: 'Login', nickname: 'guest', email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
    end
end

def full_name
    last_name + first_name
end

def full_name_kana
    last_name_kana + first_name_kana
end

# マイページのURLを:idからfull_nameへ変更
def to_param
  full_name
end


#フォロー機能 class_nameでRelationshipを指定
# フォローしている
has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
# フォローされてる
has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

#フォローしている人
has_many :follower_customer, through: :followed, source: :follower
#今、自分にフォローしている人
has_many :following_customer, through: :follower, source: :followed

# フォローしたときの処理
def follow(customer_id)
  follower.create(followed_id: customer_id)
end
# フォローを外すときの処理
def unfollow(customer_id)
  follower.find_by(followed_id: customer_id).destroy
end
# includeメゾッドで既にフォローしているかの確認
def following?(customer)
  following_customer.include?(customer)
end


#投稿機能
has_many :posts, dependent: :destroy
#いいね機能
has_many :favorites, dependent: :destroy
# コメント機能
has_many :post_comments, dependent: :destroy


has_one_attached :profile_image

#会員アイコン画像をアップロード
def get_profile_image(size)
     unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpg')
     end
     profile_image.variant(resize:size).processed
end


#キーワード検索機能
  def self.search_for(content, method)
    # 検索バーの記述　"完全一致"=>"perfect","部分一致"=>"partial"
    if method == 'perfect'
      # 完全一致
      Customer.where(nickname: content)
    else
      # 部分一致　'%'+content+'%'
      Customer.where('nickname LIKE ?', '%'+content+'%')
    end
  end


end
