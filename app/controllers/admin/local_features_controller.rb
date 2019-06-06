class Admin::LocalFeaturesController < Admin::ApplicationController
  include Admin::Concerns::PermitParams

  private

  def local_feature_params
    params.require(:local_feature)
          .permit([:caption,
                   :title,
                   :tag_list,
                   :active,
                   standalone_images_params])
  end
end
