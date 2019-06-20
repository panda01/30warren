module ApplicationHelper

  def page_content(name)
    content_tag :div, class: "page-wrapper #{name.to_s.dasherize}-content" do
      render partial: "shared/#{name}", layout: 'page_content', locals: {name: name}
    end
  end

  ###################################################################
  ##### Meta & CSS ##################################################
  ###################################################################

  def page_title
    [
      (content_for(:page_title) || t('project.seo_name')),
      t('project.name')
    ].compact.join(' | ').html_safe
  end

  def page_description
    content_for(:page_description) || t('description.default')
  end

  def page_keywords
    content_for(:page_keywords) || t('keywords.default')
  end

  def body_classes
    [@page.slug].compact.join(' ')
  end

  def current_page
    @page || MissingPage.new
  end


  ###################################################################
  ##### Navigation ##################################################
  ###################################################################

  def link_to_nav(name, path)
    link_to(name, path, class: current_page_class(path))
  end

  def current_page_class(path)
    current_page?(path) ? 'active' : ''
  end

  def section name, header: true
    sec = content_tag(:div, id: name.to_s.parameterize, class: "section") do
      concat section_header(name) if header
      yield if block_given?
    end
    concat sec
  end

  def section_header name
    content_tag(:div, class: "header") do
      content_tag(:h2, name)
    end
  end

  def hr
    content_tag :div, '', class: 'hr'
  end

  def attribute_tag(attr, object, tag: :div)
    return unless object.send("#{attr}?")
    content_tag tag, object.send(attr).html_safe, class: attr
  end

  def select_options(arrayish)
    arrayish.map{|o| [o.capitalize, o]}
  end

  def page_navigation(page, path)
    return unless page

    render partial: 'shared/page_navigation', locals: { page: page, path: path }
  end

  def image_tag_with_placeholder(image, options = {})
    size = options.delete(:size) || :full_width
    placeholder_options = {
      background: options.delete(:background)
    }

    unless options.delete(:lightboxable) == false
      placeholder_options.merge!({
        class: 'lightboxable',
        data: {
          hires: image.attachment_url(:full_screen)
        }
      })
    end

    placeholder image.attachment_url(size), image.width, image.height, placeholder_options do
      image_tag image.attachment_url(size), options
    end
  end

  def logo_image_tag_with_placeholder(image, options = {})
    size = options.delete(:size) || :full_width
    placeholder_options = {
      background: options.delete(:background)
    }

    unless options.delete(:lightboxable) == false
      placeholder_options.merge!({
        class: 'lightboxable',
        data: {
          hires: image.attachment_url(:full_screen)
        }
      })
    end

    placeholder image.attachment_url, image.width, image.height, placeholder_options do
      image_tag image.attachment_url, options
    end
  end

  def placeholder(src, width, height, options = {}, &block)
    padding = (height.to_f / width.to_f * 100).to_i
    style = "padding-top: #{padding}%;"
    style << "background-image: url('#{src}');" if options.delete(:background)
    options[:class] = ['placeholder', options[:class]].compact.join(' ')
    options[:style] = style
    content_tag :div, **options, &block
  end

  def image_with_proxy(image, size: :c4)
    url = image.attachment_url(size)
    style = "background-image: url('#{url}')"
    data = {
      original_height: image.height,
      original_width: image.width
    }
    content_tag :div, image_tag(url), class: 'image-proxy', style: style, data: data
  end

  def image_with_proxy_and_link(image_block, size: :c4)
    image_with_proxy(image_block.image, size: size) + image_block_link(image_block.caption)
  end

  def image_block_link(content)
    content_tag :div, content.html_safe, class: 'image-link'
  end

  def link_to_public_site(*args, &block)
    args << root_url(subdomain: false)
    link_to(*args, &block)
  end

  def embedded_svg filename, options = {}
    file = File.read(Rails.root.join('app', 'assets', 'svg', filename))
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    svg['class'] = options[:class] if options[:class].present?
    doc.to_html.html_safe
  end

  def tel_to number
    link_to number, tel_uri(number)
  end

  def tel_uri number, cc: "1"
    "tel:+#{cc}#{number.to_s.gsub(/\D/, '')}"
  end

  def grouped_blocks blocks
    blocks.reduce([]) do |groups, block|
      if groups.empty? || group_complete?(groups.last)
        groups << [block]
      else
        groups.last << block
      end

      groups
    end
  end

  def group_complete? group
    return false if group.empty?

    group_ends_with_full_width?(group) ||
      group_ends_with_two_half_widths?(group)
  end

  def group_ends_with_full_width? group
    group.last.advance_width == :full
  end

  def group_ends_with_two_half_widths? group
    group.length >= 2 && group[-2].advance_width == :half && group[-1].advance_width == :half
  end

  def page_path page
    meth = ::Page::PAGE_PATHS[page.slug.to_s]
    raise "No path defined for #{page.slug} page" unless meth
    send(meth)
  end

  def intersperse_images press_clippings
    images = [
      PressDecoration.new(["press/decoration-3.jpg", "press/decoration-4.jpg"]),
      PressDecoration.new(["press/decoration-5.jpg", "press/decoration-7.jpg"]),
      PressDecoration.new(["press/decoration-2.jpg", "press/decoration-6.jpg"]),
      PressDecoration.new(["press/decoration-1.jpg", "press/decoration-8.jpg"])
    ]
    groups = press_clippings.in_groups(images.length, false)
    groups.flat_map.with_index do |group, i|
      image = images[i]

      if image
        group.dup.insert(1, image).compact
      else
        group.dup
      end
    end
  end

end
