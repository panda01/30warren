class Place < ActiveRecord::Base
  include Brb::Model::Full

  before_save :set_lat_long, if: :address_changed?

  validates_presence_of :name,
                        :address,
                        :zip,
                        :category

  sluggable :name

  has_heading 'Name', link: 'name', default: true
  has_heading 'Address', link: 'address'
  has_heading 'Category', link: 'category'
  has_heading 'Active', link: 'active'

  def self.categories
    [
      'Shopping & Wellness',
      'Food & Drink',
      'Schools & Culture',
      'Landmarks & Green Spaces',
      'Home',
    ]
  end

  def self.public_categories
    public_places.collect{ |p| p[0] }.uniq
  end

  def self.public_places
    all.reject   { |p| p.category == 'Home' }
       .sort_by  { |p| p.name.downcase }
       .group_by { |p| p.category }
       .sort_by  { |c| c[0].downcase }
       .reject   { |c| c.length < 1 }
  end

  def self.grouped_places
    grouped_places = []
    Place.where(active: true).each do |place|
      if place.lat && place.long && place.address
        current_place = place.place_array
        grouped_places << current_place
      end
    end
    grouped_places
  end

  def self.home_pin
    home = Place.where(category: 'home').first
    home.place_array
  end

  def place_array
    [self.name, self.lat, self.long, self.address, self.category, self.slug, self.category.parameterize]
  end

  def address_zip
    "#{address} #{zip}"
  end

  def alias_locations
    return [self] unless aliases?

    clones = aliases.lines.map do |name|
      clone = self.dup
      clone.name = name
      clone
    end

    [self, *clones]
  end

  private

  def set_lat_long
    google_url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{CGI.escape(address_zip)}&sensor=false"
    google_result = open(google_url).read
    parsed_json = ActiveSupport::JSON.decode(google_result)

    if parsed_json['status'] == 'OK'
      self.lat = parsed_json['results'][0]['geometry']['location']['lat'].to_f
      self.long = parsed_json['results'][0]['geometry']['location']['lng'].to_f
    end
  end
end
