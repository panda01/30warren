class AddPriceRangeToRegistrants < ActiveRecord::Migration
  def change
    add_column :registrants, :price_range, :string
    add_column :registrants, :contact_preference, :string
  end
end
