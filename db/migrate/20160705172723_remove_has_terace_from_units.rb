class RemoveHasTeraceFromUnits < ActiveRecord::Migration
  def change
    remove_column :units, :has_terace, :boolean
  end
end
