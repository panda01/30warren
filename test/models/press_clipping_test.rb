require 'test_helper'

class PressClippingTest < ActiveSupport::TestCase

  test "should accept long urls" do
    press_clipping = PressClipping.create(
      url: "http://newyorkyimby.com/2015/10/first-glimpse-at-30-warren-street-full-block-tribeca-condo-project-replacing-149-church-street.html?utm_source=YIMBY+News&utm_campaign=cde8c3d256-YIMBY_News_10_6_2015&utm_medium=email&utm_term=0_d76c6a6290-cde8c3d256-137555689&ct=t(YIMBY_News_10_6_2015)",
      source: "Source",
      blurb: "Blurb",
      title: "Title",
      date: Date.today
    )
    assert press_clipping.valid?
  end

end
