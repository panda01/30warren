class Admin::AmenitiesController < Admin::ApplicationController
  include Admin::Concerns::PermitParams

  private

  def amenity_params
    params.require(:amenity)
          .permit([:caption,
                   :tag_list,
                   :active,
                   :title,
                   standalone_images_params])
  end
end
