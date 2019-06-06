class PressDecoration
  attr_reader :files

  def initialize files
    @files = files
  end

  def to_partial_path
    "press_clippings/press_decoration"
  end
end
