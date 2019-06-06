class AddTitleToViews < ActiveRecord::Migration
  def change
    add_column :views, :title, :string
  end
end
