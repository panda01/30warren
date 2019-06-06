(function($) {
  var customPaging = function(slider, i) {
    return '<div class="dot" data-role="none"></div>';
  };

  $.fn.subsection_slideshow = function(selector) {
    selector = selector || '.sub-section';

    var $el = $(this);
    var $header = $el.parents('.sub-section, .section').find('> header').first();

    var options = {
      slide: selector,
      prevArrow: '<a class="paginator previous">Previous</a>',
      nextArrow: '<a class="paginator next">Next</a>',
      adaptiveHeight: true,
      dots: !!$header.length,
      appendDots: $header,
      customPaging: customPaging,
      draggable: false
    };

    App.when_desktop(function() {
      $el.slick(options);
      $el.find(".paginator").resize_to_window_height({ minimum: 300 });
    });

    App.when_mobile(function() {
      try {
        $el.slick('unslick');
      } catch (e) {}
    });

    return $el;
  };
})(jQuery);
