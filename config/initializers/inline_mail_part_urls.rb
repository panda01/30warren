require 'mail'

module InlineMailPartUrls
  def url
    if ENV["INLINE_MAIL_PART_URLS"] == "true"
      "data:#{mime_type};base64,#{Base64.encode64(body.decoded)}"
    else
      super
    end
  end
end

class Mail::Part
  prepend InlineMailPartUrls
end
