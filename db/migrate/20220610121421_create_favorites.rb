class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|

      t.integer :customer_id, unll: false
      t.integer :post_id, unll: false

      t.timestamps
    end
  end
end
