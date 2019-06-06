class AddAliasesToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :aliases, :text
  end
end
