class ChangeUrlToTextForPressClippings < ActiveRecord::Migration
  def change
    change_column :press_clippings, :url, :text
  end
end
