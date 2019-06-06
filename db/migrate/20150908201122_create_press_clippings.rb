class CreatePressClippings < ActiveRecord::Migration
  def change
    create_table :press_clippings do |t|
      t.text :blurb
      t.string :source
      t.string :url
      t.integer :position
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
