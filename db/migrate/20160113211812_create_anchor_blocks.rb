class CreateAnchorBlocks < ActiveRecord::Migration
  def change
    create_table :anchor_blocks do |t|
      t.string :title
      t.integer :content_block_id
    end

    add_index :anchor_blocks, [:content_block_id]
  end
end
