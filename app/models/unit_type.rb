class UnitType < ActiveRecord::Base
  include Brb::Model::Full
  include Concerns::ContentBlocksOfType

  has_heading 'Name', link: 'name'

  has_image :floor_plan_pdf
  has_images :floor_plans
  has_images :renderings

  has_many :units

  has_content_block :text_block

  def text_blocks
    content_blocks_of_type(:text_block)
  end

end
