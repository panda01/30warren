class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.integer :floor
      t.string :letter
      t.string :name
      t.integer :number_of_bedrooms
      t.integer :number_of_bathrooms
      t.integer :price
      t.integer :interior_square_feet
      t.integer :exterior_square_feet
      t.string :status
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
