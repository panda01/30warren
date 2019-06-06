class TeamMember < ActiveRecord::Base
  include Brb::Model::Full

  has_heading "Name",     link: "name"
  has_heading "Position", link: "position", default: true
  has_heading "Active",   link: "active"

  validates :name, presence: true

  has_image

  def name_with_role
    [name, role].select(&:present?).join(', ')
  end

end
