class Admin::UnitsController < Admin::ApplicationController
  include Admin::Concerns::PermitParams

  private

  def unit_params
    params.require(:unit)
          .permit([:floor, :letter, :name, :status, :active, :price,
                   :number_of_bedrooms, :number_of_bathrooms,
                   :number_of_powder_rooms, :has_terace,
                   :interior_square_feet, :exterior_square_feet,
                   :interior_square_meters, :exterior_square_meters,
                   :monthly_taxes, :monthly_charges,
                   :unit_type_id, :exposure, :premium,
                   {
                     views_attributes: image_params
                   },
                  ])
  end
end
