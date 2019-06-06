class RemoveUnusedTextAndImageFieldsFromBlocks < ActiveRecord::Migration
  def up
    remove_column :image_blocks, :text
    remove_column :image_blocks, :text_orientation
    remove_column :feature_blocks, :text_orientation
    remove_column :feature_blocks, :caption
  end
end
