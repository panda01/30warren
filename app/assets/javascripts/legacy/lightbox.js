$(function() {
  $('.lightboxable').click(function(event) {
    event.preventDefault();

    $(this).open_lightbox({
      speed: 500,
      slick: {
        prevArrow: '<div class="arrow prev"></div>',
        nextArrow: '<div class="arrow next"></div>'
      }
    });
  });
});

// Attached *only* once for turbolinks
$(document).one('ready', function() {
  $('#lightbox-slides').on('afterChange', function(event, slick, current_slide) {
    var human_number = current_slide + 1,
        slide_total  = $('.lightbox-slide').not('.slick-cloned').length,
        text         = human_number + '/' + slide_total,
        $counter     = $('.slick-counter');

    $counter.html(text);
  }).on('afterChange', function(event, slick, current_slide) {
    var current = slick.$slides.eq(current_slide);

    current.find('iframe').play_on_load()
    slick.$slides.not(current).find('iframe').pause_on_load()

    $(this).find('.slick-list').focus();
  });

  $(document).on('click', '#close-lightbox', function(event) {
    event.preventDefault();
    close_lightbox();
  });

  $(document).keyup(function(e) {
    if (e.keyCode == 27) {
      close_lightbox();
    }
  });

  $(window).resize(function() {
    $('.resizable-video').resize_by_ratio()
  });
});

$.fn.resize_by_ratio = function() {
  return $(this).each(function() {
    var $el = $(this),
        ratio = $el.data('aspectRatio');

    if (typeof ratio === 'undefined') {
      var originalHeight = $el.height();
      var originalWidth = $el.width();
      ratio = originalHeight / originalWidth;
      $el.data('aspectRatio', ratio)
         .removeAttr('height')
         .removeAttr('width');
    }

    var parent = $el.parents('.lightbox-slide-content');
    var maxHeight = parent.height();
    var maxWidth = parent.width();

    if (maxWidth * ratio > maxHeight) {
      var height = maxHeight;
      var width = maxHeight / ratio;
    } else {
      var height = maxWidth * ratio;
      var width = maxWidth;
    }

    $el.parent().css({
      height: height,
      width: width
    });

    $el.css({
      marginTop: height / -2,
      height: height * 2,
      width: width
    });
  });
}

$.fn.play_on_load = function() {
  if (typeof $f === 'undefined') return $(this);

  return $(this).each(function() {
    var $video = $(this);
    var video = $f(this);

    $video.css('opacity', 0);
    $video.parents('.video-player').addClass('loading');

    video.addEvent('ready', function() {
      video.addEvent('play', function() {
        $video.animate({'opacity': 1}, 400);
        $video.parents('.video-player').removeClass('loading');
      });

      video.api('setVolume', 0);
      video.api('play');
    });
  });
}

$.fn.pause_on_load = function() {
  if (typeof $f === 'undefined') return $(this);

  return $(this).each(function() {
    var $video = $(this);
    var video = $f(this);

    $video.css('opacity', 0);

    video.addEvent('ready', function() {
      video.api('pause');
    });
  })
}

$.fn.of_group = function(group) {
  var $this = $(this);

  if (group) {
    $this = $this.filter('[data-group=' + group + ']');
  }

  return $this;
}

$.fn.open_lightbox = function(options) {
  var $el     = $(this),
      group   = $el.data('group'),
      targets = $('.lightboxable').of_group(group);

  init_lightbox(create_slides(targets), targets.index($el), options);
}

var slide_template = ('<div class="lightbox-slide">' +
                      '  <div class="lightbox-slide-content">' +
                      '    <div class="image"></div>' +
                      '  </div>' +
                      '</div>').replace(/\s{2,}/g, '');

function add_image(image_path, slide) {
  slide.find('.image')
       .addClass('loading')
       .css('background-image', 'url(' + image_path + ')')
       .append('<img src="' + image_path + '">')
       .imagesLoaded(function() {
         slide.add($('img[src="'+image_path+'"]').parents('.slick-cloned'))
              .find('.image').removeClass('loading');
       });
}

function create_slides(targets) {
  return $.map(targets, function(el, i) {
    return create_slide(el, i, targets.length);
  });
}

function create_slide(el, i, length) {
  var $this = $(el);

  if ($this.parents('.slick-cloned').length == 0) {
    var image_id    = $this.data('id'),
        slide_class = $this.data('slide-class'),
        title       = $this.data('title'),
        inner_html  = $this.data('inner-html'),
        image_path  = $this.data('hires'),
        caption     = $this.data('caption'),
        slide       = $(slide_template);

    add_image(image_path, slide);

    if (title) {
      slide.find('.lightbox-slide-content')
           .append($('<div class="lightbox-title">').text(title));
    }

    if (inner_html) {
      slide.find('.lightbox-slide-content')
           .append(inner_html);
    }

    if (caption) {
      var $caption = $('<div class="caption">');
      $caption.text(caption);
      slide.append($caption);
    }

    if (slide_class) {
      slide.addClass(slide_class);
    }

    if (image_id) {
      slide.attr('id', image_id);
    }

    return slide;
  }
}

function init_lightbox(slides, starting_position, options) {
  options = $.extend({}, options);
  options.slick = $.extend({
    slidesToShow: 1,
    slidesToScroll: 1,
    autoplay: false,
    autoplaySpeed: 3500,
    dots: false,
    fade: false,
    infinite: true,
    speed: 0,
    lazyLoad: 'progressive',
    pauseOnHover: false,
    swipe: true
  }, options.slick);

  $('.slick-counter').show();

  $('#lightbox-slides').append(slides);

  $('#lightbox').fadeIn();

  $('#lightbox-slides').slick(options.slick);

  $('#lightbox-slides')
    .slick('goTo', starting_position)
    .slick('setOption', 'speed', options.speed, false);

  $('#lightbox-slides .slick-list')
    .focus();

  $('#lightbox-slides iframe')
    .addClass('resizable-video')
    .resize_by_ratio();

  $('.slick-active iframe').play_on_load();
}

function close_lightbox() {
  $('#lightbox').fadeOut(function() {
    try {
      $('#lightbox-slides').slick('unslick');
    } catch (e) {
    } finally {
      $('#lightbox-slides').html('');
    }
  });
}
