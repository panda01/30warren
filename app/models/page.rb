class Page < ActiveRecord::Base
  include Brb::Model::Full

  PAGE_PATHS = {
    "residences"       => :residences_path,
    "neighborhood"     => :neighborhood_path,
    "the-team"         => :team_path,
    "gallery"          => :gallery_path,
    "contact"          => :contact_path,
    "availability"     => :units_path,
    "press"            => :press_clippings_path
  }

  has_heading 'Name', link: 'name'
  has_heading 'Position', link: 'position', default: true
  has_heading 'Active', link: 'active'

  has_content_block :anchor_block
  has_content_block :feature_block
  has_content_block :file_block
  has_content_block :image_block
  has_content_block :map_block
  has_content_block :panorama_block
  has_content_block :slideshow_block
  has_content_block :team_block
  has_content_block :text_block
  has_content_block :text_with_logo_block

  sluggable :name

  scope :positioned, -> { self.where(active: true).order(:position) }
  scope :with_path, -> { where(slug: PAGE_PATHS.keys)}

  def self.navigation
    positioned.where(in_primary_nav: true)
  end

  def jump_links
    content_blocks.reject {|cb| cb.block_type != 'AnchorBlock'}
  end

  def text_blocks
    content_blocks.reject {|cb| cb.block_type != 'TextBlock'}
  end

  def from_param(param)
    find_by!(slug: param)
  end

  def successive_pages
    self.class.with_path.where("position > ?", position)
  end

  def next
    successive_pages.first
  end

  def next?
    successive_pages.any?
  end
end
