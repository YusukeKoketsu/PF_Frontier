class PostComment < ApplicationRecord

  belongs_to :customer
  belongs_to :post

  validates :comment, presence: true, length: { maximum: 50 }

end
