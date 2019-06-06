class AddDefaultNumberOfRoomsToUnits < ActiveRecord::Migration
  def change
    change_column :unit_types, :number_of_bedrooms, :integer, default: 0
    change_column :unit_types, :number_of_bathrooms, :integer, default: 0
    change_column :unit_types, :number_of_powder_rooms, :integer, default: 0
  end
end
