class PlacesController < ApplicationController
  with_page :neighborhood

  def index
    @jump_links = @page.jump_links.collect(&:anchor_block).collect(&:title)
  end
end
