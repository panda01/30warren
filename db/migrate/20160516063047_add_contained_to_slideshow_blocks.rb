class AddContainedToSlideshowBlocks < ActiveRecord::Migration
  def change
    add_column :slideshow_blocks, :contained, :boolean
  end
end
