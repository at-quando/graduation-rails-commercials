class CreateShops < ActiveRecord::Migration[5.1]
  def change
    create_table :shops do |t|
      t.string :name
      t.string :image
      t.string :address
      t.string :logo
      t.string :description
      t.string :slogan
      t.string :status
      t.float :rating, default: 0.0
      t.integer :number_review, default: 0
      
      t.timestamps
    end
  end
end
