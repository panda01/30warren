# This migration comes from brb_foundation_engine (originally 20150622173700)
class AddHelpedByToBuyer < ActiveRecord::Migration
  def change
    add_column :buyers, :helped_by, :string
  end
end
