module PlacesHelper

  def place_target_id(place)
    "##{place.parameterize}-place-wrapper"
  end

  def place_css_id(name)
    "#{name.parameterize}-place-wrapper"
  end

  def places_per_column(category)
    (category.length / 3.0).ceil
  end

  def places_by_category(places)
    # places.group_by(&:category)
    Hash[places.group_by(&:category).sort_by{|x,y| x.length - y.length}]
  end

end
