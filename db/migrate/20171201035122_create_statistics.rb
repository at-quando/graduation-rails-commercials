class CreateStatistics < ActiveRecord::Migration[5.1]
  def change
    create_table :statistics do |t|
      t.integer :all_reviews
      t.integer :all_products
      t.float :all_rating

      t.timestamps
    end
  end
end
