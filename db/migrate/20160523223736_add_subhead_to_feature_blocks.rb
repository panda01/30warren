class AddSubheadToFeatureBlocks < ActiveRecord::Migration
  def change
    add_column :feature_blocks, :subhead, :string, default: "Features"
  end
end
