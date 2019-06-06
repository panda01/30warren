class Admin::BuyersController < Admin::ApplicationController
  include Admin::Concerns::PermitParams

  private

  def buyer_params
    params.require(:buyer)
          .permit(:first_name, :last_name, :slug, :email, :message, :helped_by)
  end
end
