class SalesAgent < ActiveRecord::Base
  include Brb::Model::Full

  has_heading 'Name',          link: 'name', default: true
  has_heading 'Phone #',       link: 'phone_number'
  has_heading 'Email Address', link: 'email_address'

  has_image :signature

end
