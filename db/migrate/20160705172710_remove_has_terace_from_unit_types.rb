class RemoveHasTeraceFromUnitTypes < ActiveRecord::Migration
  def change
    remove_column :unit_types, :has_terace, :boolean
  end
end
