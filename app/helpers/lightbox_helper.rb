module LightboxHelper

  def lightbox_image_tag src, options = {}
    options[:data] ||= {}
    classes = Array.wrap options.delete(:class)
    classes << 'lightboxable'

    if options.delete(:secret)
      classes << 'secret'
    end

    if slide_class = options.delete(:slide_class)
      options[:data][:slide_class] = Array.wrap(slide_class).join(' ')
    end

    options[:data][:hires] = asset_path(options.delete(:hires) || src)

    %i{ group caption title inner_html }.each do |attr|
      if val = options.delete(attr)
        options[:data][attr] = val
      end
    end

    if partial = options.delete(:render)
      options[:data][:inner_html] = render(partial).gsub('\n', '')
    end

    options[:class] = classes.compact.join ' '

    image_tag src, options
  end

  def lightbox_video_tag src, options = {}
    options[:data] ||= {}

    classes = Array.wrap options.delete(:class)
    classes << 'lightboxable-video'
    options[:class] = classes.compact.join ' '
    options[:slide_class] = 'video-slide'

    if vimeo_id = options.delete(:vimeo_id)
      options[:data][:inner_html] = vimeo(id: vimeo_id, width: 500, height: 281).gsub('\n', '')
    end

    lightbox_image_tag src, options
  end

  def placeholder_lightbox_image(secret: false)
    name = secret ? 'placeholder-hidden.png' : 'placeholder.png'
    lightbox_image_tag name, width: 1250, height: 833, secret: secret
  end

end