(function($) {
  var shieldImages = function() {
    $('.wrapper img').each(function() {
      var el = $(this);

      el.addClass('loading');
      el.imagesLoaded(function() {
        el.removeClass('loading');
        el.addClass('loaded');
      })
    });
  };

  $(shieldImages);
})(jQuery);
