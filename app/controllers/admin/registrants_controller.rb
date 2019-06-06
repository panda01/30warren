class Admin::RegistrantsController < Admin::ApplicationController
  include Admin::Concerns::PermitParams

  respond_to :csv, only: :index

  has_scope :page, default: 1, unless: -> cont { cont.request.format.csv? }

  private

    def registrant_params
      params.require(:registrant).permit(
        :first_name,
        :last_name,
        :email,
        :phone,
        :zip_code,
        :price_range,
        :residence_size,
        :referral_channel
      )
    end
end
