class CreateHashtags < ActiveRecord::Migration[6.1]
  def change
    create_table :hashtags do |t|
      t.string :hashname

      t.timestamps
    end
    #名前に一意性を持たせる
    add_index :hashtags, :hashname, unique: true
  end
end
