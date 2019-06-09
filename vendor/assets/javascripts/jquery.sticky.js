$.fn.sticky = function(options) {
  options = options || {};

  $(this).each(function() {
    new Waypoint.Sticky($.extend({
      offset: 0,
      element: this
    }, options));
  })
}
