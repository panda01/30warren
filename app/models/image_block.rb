class ImageBlock < ActiveRecord::Base
  include Concerns::HasImage
  include AASM

  belongs_to :content_block

  has_image :image

  aasm :treatment do
    state :cover, initial: :true
    state :contain
  end

  aasm :height_style do
    state :inherit, initial: :true
    state :window_height
  end

  def is_half_width?
    size == 'half'
  end

  def is_full_width?
    size == 'full'
  end

  def text_orientation
    self[:text_orientation] || "left"
  end

  def as_json(options = {})
    options.reverse_merge! only: [:title, :caption]
    super(options)
  end

  def advance_width
    size.to_sym
  end

  def title_card?
    is_full_width? && title? && caption?
  end

end
