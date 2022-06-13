class PostComment < ApplicationRecord

  belongs_to :customer
  belongs_to :post

  # レビューの星マークの設定　数値のみを許可する為numericalityを使用 1～5までとする
  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1}, presence: true

end
