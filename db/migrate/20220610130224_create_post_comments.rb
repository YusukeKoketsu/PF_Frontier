class CreatePostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comments do |t|

      t.integer :customer_id, unll: false
      t.integer :post_id, unll: false
      t.text :comment, unll: false

      t.timestamps
    end
  end
end
