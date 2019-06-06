class AddVisibleBooleanToAnchorBlocks < ActiveRecord::Migration
  def change
    add_column :anchor_blocks, :visible, :boolean, default: false
  end
end
