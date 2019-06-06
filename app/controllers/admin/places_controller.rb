class Admin::PlacesController < Admin::ApplicationController
  include Admin::Concerns::PermitParams

  private

  def place_params
    params.require(:place)
          .permit([:name, :address, :zip, :category, :long, :lat, :slug, :active, :aliases])
  end
end
