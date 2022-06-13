class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :customer_id, null: false
      t.integer :category_id, null: false
      t.string :title, null: false
      t.text :introduction, null: false
      t.float :rate, unll: false, default: 0

      t.timestamps
    end
  end
end
