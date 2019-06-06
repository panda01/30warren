class AddTitleToPressClippings < ActiveRecord::Migration
  def change
    add_column :press_clippings, :title, :string
  end
end
