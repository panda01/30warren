class AddExposureToUnits < ActiveRecord::Migration
  def change
    add_column :units, :exposure, :string
  end
end
