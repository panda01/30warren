class AddTitleToLocalFeatures < ActiveRecord::Migration
  def change
    add_column :local_features, :title, :string
  end
end
