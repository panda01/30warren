class BuildingController < ApplicationController

  with_page :building

  def show
    @jump_links = @page.jump_links.collect(&:anchor_block).collect(&:title)
  end

end
