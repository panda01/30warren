$(function() {
  $('.jump-links').click(function() {
    $(this).parent().toggleClass('is-open');
  });

  $('.jump-links .jump-links').siblings('a').click(function(event) {
    if (Layout.breakpoint === Layout.Desk) {
      event.preventDefault();
      event.stopPropagation();
      $(this).parent().toggleClass('is-open');
    }
  });

  $('.jump-links a, .welcome .unit a').click(function(event) {
    event.preventDefault();

    if (!event.isPropagationStopped()) {
      var destination = $(this).attr('href');
      var $target     = $(destination);
      var y_offset    = $target.offset().top - 110;

      $('.jump-links').css('display', '');

      $('html, body').animate({ scrollTop: y_offset });
    }
  });

  $('.jump-top').click(function(event) {
    event.preventDefault();

    $('html, body').animate({ scrollTop: 0 });
  });

  $('.section').waypoint(function(direction) {
    var current_section_id = $(this.element).attr('id');
    var $current_jump_link = $('.jump-links li a.is-active');

    if (direction == 'up') {
      $current_jump_link.parent().prev().find('a').addClass('is-active');
      $current_jump_link.removeClass('is-active');
    } else {
      var $next_jump_link = $('.jump-links li a[href=#' + current_section_id + ']');
      $('.jump-links li a').not($next_jump_link).removeClass('is-active');
      $next_jump_link.addClass('is-active');
    }
  }, {
    offset: function() {
      return $('.content-header').outerHeight()
    }
  });

  $('.menu-toggle').click(function() {
    $(this).siblings('.jump-links').slideToggle();
  })
});

$(document).one('ready', function() {
  remove_class_on_body_click('is-open', '.jump-links li');
});

(function() {
  var $window = $(window);

  var jump_links_close_to_buttom = function() {
    var close_to_bottom = $window.scrollTop() < 45;
    $('.jump-links').toggleClass('is-close-to-bottom', close_to_bottom);
  };

  $window.on('scroll', jump_links_close_to_buttom);

  $(jump_links_close_to_buttom);
})();

App.when_desktop(function() {
  $('.jump-links').css('display', '');
})
