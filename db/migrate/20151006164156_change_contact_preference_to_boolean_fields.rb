class ChangeContactPreferenceToBooleanFields < ActiveRecord::Migration
  def up
    add_column :registrants, :contactable_by_email, :boolean, default: true
    add_column :registrants, :contactable_by_phone, :boolean, default: false

    Registrant.find_each do |registrant|
      registrant.update_attributes({
        contactable_by_email: registrant.contact_preference == 'email',
        contactable_by_phone: registrant.contact_preference == 'phone'
      })
    end
  end

  def down
    remove_column :registrants, :contactable_by_email, :boolean
    remove_column :registrants, :contactable_by_phone, :boolean
  end
end
