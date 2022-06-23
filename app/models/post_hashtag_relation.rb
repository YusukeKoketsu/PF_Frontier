class PostHashtagRelation < ApplicationRecord

  belongs_to :post
  belongs_to :hashtag

  #  with_optionsでpost_idとhashtag_idにpresence: true設定を付ける
  with_options presence: true do
    validates :post_id
    validates :hashtag_id
  end

end
