class Area

  attr_reader :measurements, :unit

  def initialize measurements, unit: :imperial
    @measurements = measurements
    @unit = unit
  end

  def metric
    self.class.new measurements, unit: :metric
  end

  def interior
    Dimension.new get(:interior)
  end

  def interior?
    interior.present? && interior > 0
  end

  def exterior
    Dimension.new get(:exterior)
  end

  def exterior?
    exterior.present? && exterior > 0
  end

  def total
    Dimension.new((get(:exterior) || 0) + (get(:interior) || 0))
  end

  private

  def get attr
    @measurements.fetch(unit, {})[attr]
  end

  class Dimension
    include Comparable
    include ActionView::Helpers::NumberHelper

    attr_accessor :size

    def initialize size
      @size = size || 0
    end

    def with_delimiter
      number_with_delimiter size
    end

    def <=> other
      other = Dimension.new(other) unless other.is_a?(Dimension)
      size <=> other.size
    end

    def to_s
      with_delimiter
    end
  end

end
