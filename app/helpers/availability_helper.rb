module AvailabilityHelper

  def image_hires(image)
    image.attachment_url(:full_screen)
  end

  def hires_floor_plans(unit)
    unit.floor_plans.map(&method(:image_hires))
  end

  def hires_renderings(unit)
    unit.renderings.map(&method(:image_hires))
  end

end
