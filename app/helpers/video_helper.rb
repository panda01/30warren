module VideoHelper
  def vimeo(id:, width:, height:)
    content_tag :div, class: "video-player", data: { transition_fixed: true } do
      content_tag :div, class: "video-wrapper" do
        vimeo_iframe src: vimeo_src(id), width: width, height: height
      end
    end
  end

  def vimeo_src id
    "//player.vimeo.com/video/#{id}?loop=1&badge=0&byline=0&portrait=0&title=0?api=1"
  end

  def vimeo_iframe(src:, width:, height:)
    content_tag :iframe, '',
                         src: src,
                         width: width,
                         height: height,
                         frameborder: 0
  end
end