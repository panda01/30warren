class Admin::ViewsController < Admin::ApplicationController
  include Admin::Concerns::PermitParams

  private

  def view_params
    params.require(:view)
          .permit([:caption,
                   :title,
                   :tag_list,
                   :active,
                   standalone_images_params])
  end
end
