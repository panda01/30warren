class Admin::SalesAgentsController < Admin::ApplicationController
  include Admin::Concerns::PermitParams

  private

  def sales_agent_params
    params.require(:sales_agent)
          .permit([:name,
                   :phone_number,
                   :email_address,
                   { signature_attributes: image_params }])
  end
end
