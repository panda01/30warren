class Admin::PressClippingsController < Admin::ApplicationController
  include Admin::Concerns::PermitParams

  private

  def press_clipping_params
    params.require(:press_clipping)
          .permit([:blurb, :source, :url, :active, :date,
                   :title, standalone_images_params,
                   pdf_attributes: image_params])
  end
end
