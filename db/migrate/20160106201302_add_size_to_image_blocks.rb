class AddSizeToImageBlocks < ActiveRecord::Migration
  def change
    add_column :image_blocks, :size, :string, default: 'full', null: false
  end
end
