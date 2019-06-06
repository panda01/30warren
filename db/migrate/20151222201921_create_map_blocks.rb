class CreateMapBlocks < ActiveRecord::Migration
  def change
    create_table :map_blocks do |t|
      t.references :content_block
      t.string :title
      t.timestamps null: false
    end
  end
end
