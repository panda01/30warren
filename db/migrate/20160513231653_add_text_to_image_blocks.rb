class AddTextToImageBlocks < ActiveRecord::Migration
  def change
    add_column :image_blocks, :text, :text
    add_column :image_blocks, :text_orientation, :string
  end
end
