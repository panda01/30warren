class AddDuplexOptionToUnitTypes < ActiveRecord::Migration
  def change
    add_column :unit_types, :duplex, :boolean, default: false
  end
end
