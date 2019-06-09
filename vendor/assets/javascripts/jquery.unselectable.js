(function($) {
  $.fn.unselectable = function() {
    return $(this).attr('unselectable', 'on')
                  .css('user-select', 'none')
                  .on('selectstart', false);
  };
})(jQuery);
