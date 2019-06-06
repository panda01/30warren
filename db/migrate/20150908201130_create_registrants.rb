class CreateRegistrants < ActiveRecord::Migration
  def change
    create_table :registrants do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :country
      t.string :residence_size
      t.boolean :is_a_broker
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
