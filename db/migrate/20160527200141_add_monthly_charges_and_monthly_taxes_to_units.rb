class AddMonthlyChargesAndMonthlyTaxesToUnits < ActiveRecord::Migration
  def change
    add_column :units, :monthly_charges, :integer
    add_column :units, :monthly_taxes, :integer
  end
end
