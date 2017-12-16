class CreateRatingShops < ActiveRecord::Migration[5.1]
  def change
    create_table :rating_shops do |t|
      t.belongs_to :user
      t.belongs_to :shop
      t.integer :quality
      t.integer :service
      t.integer :warranty
      t.integer :delivery
      t.float :total
      t.string :review_shop

      t.timestamps
    end
  end
end
