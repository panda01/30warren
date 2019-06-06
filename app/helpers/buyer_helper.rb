module BuyerHelper

  def units_to_compare_to(units, unit)
    units.reject do |u|
      unit == u || u.floor_plans.empty?
    end
  end

end
