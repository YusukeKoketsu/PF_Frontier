class Hashtag < ApplicationRecord

  has_many :post_hashtag_relations, dependent: :destroy
  # post_hashtag_relationsを経由してpostへ
  has_many :posts, through: :post_hashtag_relations

  validates :hashname, presence: true, length: { maximum:50}

end
