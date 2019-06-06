$(document).on('ready page:load', function () {
  $('.jump-links a').click(function(event) {
    event.preventDefault();

    var destination = $(this).attr('href');

    $(window).scrollTop(offset_from_hash(destination));
  });

  $('div[name]').waypoint(function(direction) {
    var current_section_id = $(this.element).attr('name');
    var $jump_links = $('.jump-links a');
    var $current_jump_link = $jump_links.filter('.active');

    if (direction === 'up') {
      if ($jump_links.index($current_jump_link) > 0) {
        $current_jump_link.parent().prev().find('a').addClass('active');
        $current_jump_link.removeClass('active');
      } else {
        $jump_links.removeClass('active');
      }
    } else {
      var $next_jump_link = $jump_links.filter('[href=#' + current_section_id + ']');

      $jump_links.not($next_jump_link).removeClass('active');
      $next_jump_link.addClass('active');
    }
  }, {
    offset: function() { return get_header_height() + 2; }
  });
})
