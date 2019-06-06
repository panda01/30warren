class AddWidthToFeatureBlocks < ActiveRecord::Migration
  def change
    add_column :feature_blocks, :width, :string
  end
end
