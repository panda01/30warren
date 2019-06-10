class TextWithLogoBlock < ActiveRecord::Base
  include Concerns::HasImage

  belongs_to :content_block
  has_image :logo

  validates_presence_of :body
  validates_length_of :title, maximum: 255

  def as_json(options = {})
    options.reverse_merge! only: [:title, :body]
    super(options)
  end

  def advance_width
    :half
  end
end
