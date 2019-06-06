class AnchorBlock < ActiveRecord::Base

  belongs_to :content_block

  validates_presence_of :title
  validates_length_of :title, maximum: 255

  def advance_width
    visible? ? :full : :none
  end

end
