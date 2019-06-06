class AddBodyToAnchorBlocks < ActiveRecord::Migration
  def change
    add_column :anchor_blocks, :body, :text
  end
end
