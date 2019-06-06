class AddTitleToAmenities < ActiveRecord::Migration
  def change
    add_column :amenities, :title, :string
  end
end
