class TeamBlock < ActiveRecord::Base

  belongs_to :content_block

  validates_presence_of :body, :title
  validates_length_of :title, :subtitle, maximum: 255

  def as_json(options = {})
    options.reverse_merge! only: [:title, :body]
    super(options)
  end

  def advance_width
    :half
  end

end
