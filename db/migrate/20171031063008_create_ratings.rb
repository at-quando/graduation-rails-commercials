class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.belongs_to :user
      t.belongs_to :product
      t.float :rate

      t.timestamps
    end
  end
end
