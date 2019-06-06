class AddEnlargeableToImageBlocks < ActiveRecord::Migration
  def change
    add_column :image_blocks, :enlargeable, :boolean, default: true
  end
end
