class AddIsPanoramaBooleanToSlideshowBlocks < ActiveRecord::Migration
  def change
    add_column :slideshow_blocks, :is_panorama, :boolean, default: false
  end
end
