module FeatureDescriptor
  extend ActiveSupport::Concern

  included do
    has_heading 'Title',
                link: 'title'
    has_heading 'Caption',
                link: 'caption',
                display: :truncated_caption
    has_heading 'Position',
                link: 'position',
                default: true
    has_heading 'Active',
                link: 'active'

    has_image

    acts_as_taggable_on :tags
  end

  def truncated_caption(length = 60)
    caption.slice(0, length) + (caption.length > length ? '...' : '')
  end

end
