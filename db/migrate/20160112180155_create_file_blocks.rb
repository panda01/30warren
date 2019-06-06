class CreateFileBlocks < ActiveRecord::Migration
  def change
    create_table :file_blocks do |t|
      t.string :title, null: false
      t.string :subtitle, null: false
      t.integer :content_block_id
      t.text :body
      t.string :file
    end

    add_index :file_blocks, [:content_block_id]
  end
end
