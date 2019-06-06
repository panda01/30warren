class AddPremiumToUnits < ActiveRecord::Migration
  def change
    add_column :units, :premium, :boolean, default: false
  end
end
