class Admin::TeamMembersController < Admin::ApplicationController
  include Admin::Concerns::PermitParams

  private

  def team_member_params
    params.require(:team_member)
          .permit([:name,
                   :role,
                   :description,
                   :position,
                   :active,
                   standalone_images_params])
  end
end
