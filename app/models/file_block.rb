class FileBlock < ActiveRecord::Base
  include Concerns::HasImage

  belongs_to :content_block

  validates_presence_of :body, :title, :link_text
  validates_length_of :title, :subtitle, maximum: 255

  has_image :file

  def as_json(options = {})
    options.reverse_merge! only: [:title, :body]
    super(options)
  end

  def advance_width
    :half
  end

end
