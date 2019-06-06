class PressClipping < ActiveRecord::Base
  include Brb::Model::Full

  LOGOS = {
    "Arch Daily" => "press/archdaily.png",
    "Architect Magazine" => "press/architectmagazine.png",
    "Architects Newspaper" => "press/architectsnewspaper.png",
    "ASPIRE" => "press/aspire.png",
    "New York YIMBY" => "press/yimby.png",
    "Observer" => "press/observer.png",
    "The New York Times" => "press/nytimes.png",
    "The Real Deal" => "press/realdeal.png",
    "World Architecture News" => "press/worldarchitecturenews.png",
    "Wallpaper*" => "press/wallpaper.png",
    "Trouge Magazine" => "press/trouge.png",
    "New York Design Agenda" => "press/new-york-design-agenda.png",
  }

  has_heading 'Source', link: 'source'
  has_heading 'URL', link: 'url'
  has_heading 'Title', link: 'title'
  has_heading 'Blurb', link: 'blurb'
  has_heading 'Date', link: 'date', default: true
  has_heading 'Active', link: 'active'

  has_image
  has_image :pdf

  validates_presence_of :source, :title, :date

  def source_url
    pdf.present? && pdf.attachment_url.present? ? pdf.attachment_url : url
  end

  def logo?
    logo.present?
  end

  def logo
    LOGOS[source]
  end

  def alternate_logo
    path, ext = LOGOS[source].split('.')
    "#{path}-alternate.#{ext}"
  end
end
