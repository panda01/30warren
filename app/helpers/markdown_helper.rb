module MarkdownHelper

  MARKDOWN = Redcarpet::Markdown.new(Redcarpet::Render::HTML) unless defined?(MARKDOWN)

  def smarty(stringish)
    Redcarpet::Render::SmartyPants.render(stringish.to_s).html_safe
  end
  alias_method :s, :smarty

  def markdown(stringish)
    MARKDOWN.render(stringish.to_s).html_safe
  end
  alias_method :m, :markdown

  def format(stringish)
    smarty(markdown(stringish))
  end
  alias_method :f, :format

  def format_title(stringish)
    text = format(stringish)
    text = Regexp.new('^<p>(.*)<\/p>$').match(text)[1] rescue text
    text.html_safe
  end
  alias_method :ft, :format_title

  def strip_markdown(stringish)
    strip_tags(m(stringish)).html_safe
  end

end