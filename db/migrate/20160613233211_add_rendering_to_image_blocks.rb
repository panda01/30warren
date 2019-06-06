class AddRenderingToImageBlocks < ActiveRecord::Migration
  def change
    add_column :image_blocks, :rendering, :boolean, default: false
  end
end
