class AddDateToPressClipping < ActiveRecord::Migration
  def change
    add_column :press_clippings, :date, :date
  end
end
