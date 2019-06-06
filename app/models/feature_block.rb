class FeatureBlock < ActiveRecord::Base
  include Concerns::HasImage
  include AASM

  belongs_to :content_block

  validates_presence_of :features
  validates_length_of :title, maximum: 255

  aasm :width do
    state :half, initial: true
    state :full
  end

  def as_json(options = {})
    options.reverse_merge! only: [:title, :body]
    super(options)
  end

  def advance_width
    aasm(:width).current_state
  end

end
