class Admin::UnitTypesController < Admin::ApplicationController
  include Admin::Concerns::PermitParams

  private

  def unit_type_params
    params.require(:unit_type)
          .permit([:name, :description, :duplex,
                   :number_of_bedrooms, :number_of_bathrooms,
                   :number_of_powder_rooms, :has_terace, :penthouse,
                   :interior_square_feet, :exterior_square_feet,
                   :interior_square_meters, :exterior_square_meters,
                   {
                     floor_plans_attributes: image_params,
                     floor_plan_pdf_attributes: image_params,
                     renderings_attributes: image_params
                   },
                   content_block_params])
  end
end
