$(function() {
  $(document).on('click', '.other-units a', function() {
    var compare_id = $(this).data('compare-id');

    var $current_unit = $(this).parents('.unit');
    var $compare_unit = $('#residences-' + compare_id);

    compare_units($current_unit, $compare_unit);
  })
});

function compare_units($current, $compare) {
  var $container = $('<div class="comparitor">');

  var $current_comparator = create_comparator('current',
                                              $current.data('unit-name'),
                                              $current.find('.floor-plan'));

  var $compare_comparator = create_comparator('compare',
                                              $compare.data('unit-name'),
                                              $compare.find('.floor-plan'));

  $container.append($current_comparator)
            .append($compare_comparator);

  $container.find('.image').css('height', '');

  $container.find('.floor-plan, img, .image, .image-padding, .image-proxy')
            .andSelf()
            .attr('draggable', true);

  init_comparison_lightbox($container);
}

function create_comparator(kind, name, $floor_plans) {
  var $title = $('<div class="title">').text(name);
  var $floor_plans = $('<div class="unit-floorplans">').append($floor_plans.clone());
  $floor_plans.find('.zoomed').unzoom_image()
  return $('<div class="' + kind + '-unit">').append($title).append($floor_plans);
}

function init_comparison_lightbox(slides, options) {
  options = $.extend({}, options);
  options.slick = $.extend({
    slidesToShow: 1,
    slidesToScroll: 1,
    autoplay: false,
    autoplaySpeed: 3500,
    dots: false,
    fade: false,
    infinite: true,
    speed: App.slide_speed,
    lazyLoad: 'progressive',
    pauseOnHover: false,
    swipe: true,
    draggable: false
  }, options.slick);

  $('.slick-counter').hide();

  $('#lightbox-slides').append(slides);

  $('#lightbox').fadeIn();

  $('#lightbox .unit-floorplans').each(function() {
    options.slick.arrows = ($(this).find('.unit-image').length > 1);
    $(this).slick(options.slick);
  });
}
