class RemovePositionFromPressClippings < ActiveRecord::Migration
  def change
    remove_column :press_clippings, :position, :integer
  end
end
