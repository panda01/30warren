class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.string :slug
      t.integer :position
      t.boolean :editable
      t.boolean :in_primary_nav
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
