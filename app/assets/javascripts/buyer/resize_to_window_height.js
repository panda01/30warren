(function($) {
  $.fn.resize_to_window_height = function(options) {
    options = options || {};

    if (typeof options.minimum === 'undefined') {
      options.minimum = 300;
    }

    if (typeof options.attr === 'undefined') {
      options.attr = 'height';
    }

    var $elements = $(this);
    var $window = $(window);
    var $header = $('.floating-content, .floating-header');
    var $page_header = $header.siblings('.page-nav');
    var $page_header_height = $page_header.height() || 0;

    $window.on('resize', function() {
      var height = $window.height() - $header.outerHeight() - $page_header_height - 90;
      $elements.css(options.attr, Math.max(options.minimum, height));
      $elements.trigger('sync_height');
    }).trigger('resize');
  }
})(jQuery);
