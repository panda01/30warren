class Admin::PagesController < Admin::ApplicationController
  include Admin::Concerns::PermitParams

  private

  def page_params
    params.require(:page)
          .permit([:name, :slug, :position, :editable, :in_primary_nav, :active, content_block_params])
  end
end
