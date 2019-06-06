class Registrant < ActiveRecord::Base
  include Brb::Model::Full
  validates_presence_of :first_name, :last_name, :email
  validate :real_email_address

  has_heading 'Date',   link: 'created_at', display: :formatted_registered_date, default: true
  has_heading 'Name',   link: 'name'
  has_heading 'Residence Type', link: 'residence_type'
  has_heading 'Email',  link: 'email'
  has_heading 'Phone',  link: 'phone'

  def formatted_registered_date
    created_at.strftime('%b %d, %Y')
  end

  def self.residence_type_options
    ['1 Bedroom', '2 Bedroom', '3 Bedroom', 'Penthouse']
  end

  def self.price_range_options
    ['$1M-$3M', '$3M-$5M', '$5M-$8M', '$8M+']
  end

  def self.referral_channel_options
    ['Sign', 'Broker', 'Live in Neighborhood', 'Streeteasy.com']
  end

  def name
    [first_name, last_name].compact.join(" ")
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      columns_to_use = column_names
      columns_to_use.delete('updated_at')
      csv << columns_to_use
      all.each do |registrant|
        csv << registrant.attributes.values_at(*columns_to_use)
      end
    end
  end

  private

  def real_email_address
    unless email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      errors.add(:email, 'must be a valid address')
    end
  end
end
