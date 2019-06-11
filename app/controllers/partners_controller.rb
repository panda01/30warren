class PartnersController < ApplicationController

  with_page :partners

  def show
    @jump_links = @page.jump_links.collect(&:anchor_block).collect(&:title)
  end
end
