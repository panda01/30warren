class ResidencesController < ApplicationController

  with_page :residences

  def show
    @jump_links = @page.jump_links.collect(&:anchor_block).collect(&:title)
  end
end
