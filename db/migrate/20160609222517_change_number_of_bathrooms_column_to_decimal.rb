class ChangeNumberOfBathroomsColumnToDecimal < ActiveRecord::Migration
  def up
    change_column :units,      :number_of_bathrooms, :decimal, default: 0, scale: 1, precision: 2
    change_column :unit_types, :number_of_bathrooms, :decimal, default: 0, scale: 1, precision: 2
  end

  def down
    change_column :units,      :number_of_bathrooms, :integer, default: 0
    change_column :unit_types, :number_of_bathrooms, :integer, default: 0
  end
end
