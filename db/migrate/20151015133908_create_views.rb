class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.text :caption
      t.boolean :active, default: true
      t.integer :position
    end
  end
end
