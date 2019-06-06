$(function() {
  new Waypoint.Sticky({
    element: $('.floating-header').get(0)
  });

  new Waypoint({
    element: document.querySelector('body'),
    offset: -100,
    handler: function(direction) {
      var nav = $('.page-nav');

      nav.toggleClass('stuck', direction === 'down')

      if (direction === 'up') {
        nav.css('top', '');
      }
    }
  });

  $('.menu-toggle')
    .unselectable()
    .on('click', function(e) {
      e.preventDefault();

      // Triggers setting the padding of the navigation
      $(window).trigger('resize');

      $('.header').toggleClass('show-navigation');
      $('.page-nav.stuck').removeClass('stuck');
    });

  $('.main-nav .page.current a').on('click', function(event) {
    event.preventDefault();

    var href = $(this).attr('href');

    if (href.indexOf('#') !== -1) {
      var destination = '#' + href.split('#').pop();
      scroll_to(offset_from_hash(destination), 400);
    }

    $('.menu-toggle').trigger('click');
  });
});

$(document).one('ready', function() {
  $(window).on('resize', function() {
    $('.main-nav').css({
      paddingTop: $('.floating-header').outerHeight() - 1
    });
  });
})
