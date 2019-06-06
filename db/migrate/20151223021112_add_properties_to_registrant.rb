class AddPropertiesToRegistrant < ActiveRecord::Migration
  def change
    remove_column Registrant, :name, :string
    remove_column Registrant, :residence_size, :string
    remove_column Registrant, :country, :string
    remove_column Registrant, :is_a_broker, :boolean
    remove_column Registrant, :active, :boolean
    remove_column Registrant, :contact_preference, :string
    remove_column Registrant, :reference_channel, :string
    remove_column Registrant, :contactable_by_email, :boolean
    remove_column Registrant, :contactable_by_phone, :boolean
    add_column Registrant, :first_name, :string
    add_column Registrant, :last_name, :string
    add_column Registrant, :zip_code, :string
    add_column Registrant, :referral_channel, :string
    add_column Registrant, :residence_type, :string
  end
end
