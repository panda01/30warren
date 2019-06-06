class AddCaptionToFeatureBlocks < ActiveRecord::Migration
  def change
    add_column :feature_blocks, :caption, :string
    add_column :feature_blocks, :text_orientation, :string
  end
end
