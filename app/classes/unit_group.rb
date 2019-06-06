class UnitGroup

  attr_reader :unit

  def initialize unit
    @unit = unit
  end

  def promoted?
    unit.premium?
  end

  def == other
    (promoted? && other.promoted?) ||
      unit.number_of_bedrooms == other.unit.number_of_bedrooms
  end

  alias eql? ==

  def <=> other
    hash - other.hash
  end

  def hash
    promoted? ? 9999 : unit.number_of_bedrooms
  end

  def to_s
    if promoted?
      "Premium Residences"
    else
      "#{unit.number_of_bedrooms.to_words.capitalize} Bedrooms"
    end
  end

end
