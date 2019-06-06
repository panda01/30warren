$.fn.toggle_image_zoom = function() {
  var $image = $(this);

  if ($image.hasClass('zoomed')) {
    $image.unzoom_image();
  } else {
    $image.zoom_image();
  }

  return $image;
};

$.fn.unzoom_image = function() {
  return $(this).each(function() {
    var $image = $(this);
    var $img = $image.find('img');

    $image.removeClass('zoomed');
    $img.unwrap();

    try {
      $img.draggable('destroy');
    } catch (e) {}

    return $image;
  });
};

$.fn.zoom_image = function() {
  return $(this).each(function() {
    var $image = $(this);
    var $img = $image.find('img');

    $image.addClass('zoomed');
    $img.wrap('<div class="image-container">');
    $img.draggable({
      scroll: false,
      containment: "parent",
      distance: 10,
      create: function(event, ui) {
        var $parent = $img.parent();
        $img.css({
          top: ($parent.height() / 2) - $img.height() / 2,
          left: ($parent.width() / 2) - $img.width() / 2
        });
      }
    });

    return $image;
  });
}

$(document).on('click', '.floor-plan .image', function() {
  $(this).toggle_image_zoom();
});

$(document).one('ready', function() {
  $('#lightbox').on('beforeChange', function(event, slick, current_slide) {
    slick.$slider.find('.zoomed').unzoom_image();
  });
});
