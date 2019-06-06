class AddReferenceChannelToRegistrants < ActiveRecord::Migration
  def change
    add_column :registrants, :reference_channel, :text
  end
end
