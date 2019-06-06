class AddDefaultToIsABrokerOnRegistrants < ActiveRecord::Migration
  def change
    change_column :registrants, :is_a_broker, :boolean, default: false
  end
end
