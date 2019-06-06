module JumpLinksHelper

  def jump_links(things, attr: :itself, header: nil, format: :itself, anchor_prefix: nil)
    return unless things && things.any?

    links = things.map(&attr)

    content_tag :div, class: "jump-links" do
      jump_links_header(header) + jump_links_list(links, format: format, anchor_prefix: anchor_prefix)
    end
  end

  def jump_links_list(links, format: :itself, anchor_prefix: nil)
    content_tag :ul do
      links.map do |link|
        jump_links_link link, format: format, anchor_prefix: anchor_prefix
      end.join.html_safe
    end
  end

  def jump_links_link(link, format: :itself, anchor_prefix: nil)
    link, sublinks = Array.wrap(link)
    anchor = [anchor_prefix, link.to_s.parameterize].compact.join('-')
    href = "##{anchor}"

    content_tag :li do
      concat link_to(t(link.to_s.send(format), scope: "jump_links", default: link.to_s.send(format)), href)
      concat jump_links(sublinks, anchor_prefix: anchor)
    end
  end

  def jump_links_header label
    label ? content_tag(:h1, label) : ''.html_safe
  end

end
