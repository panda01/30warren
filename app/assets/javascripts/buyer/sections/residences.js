$(function() {
  var $units = $('.unit');

  $units.each(function() {
    var $unit = $(this);
    var $slideshow = $unit.find('.slideshow');
    var $floor_plans = $slideshow.find('.floor-plan');
    var $slides = $unit.find('.slideshow .page');
    var $floor_plan_pages = $floor_plans.parents('.page');

    $floor_plans.find('img, .image, .image-padding, .image-proxy')
                .add($floor_plans)
                .add($floor_plan_pages)
                .add($slideshow)
                .attr('draggable', true);

    if ($slides.length > 1) {
      $slideshow
        .subsection_slideshow('.page')
        .on('afterChange', function(_, slideshow, current) {
          var current_slide = slideshow.$slides.eq(current);
          var showing_floor_plan = current_slide.find('.unit-image')
                                                .hasClass('floor-plan');

          $unit.toggleClass('is-showing-floor-plan', showing_floor_plan);
        });
    }

    $unit.toggleClass('is-showing-floor-plan',
                      $unit.find('.unit-image').first().hasClass('floor-plan'));
  });

  $units.on('click', '.compare', function(event) {
    event.preventDefault();
    $(this).toggleClass('is-open');
  });

  // Needs to query units again to pick up slick clones
  $('.unit').find('.page .image').resize_to_window_height();

  $units.find('.skip-to-floor-plans').on('click', function(event) {
    event.preventDefault();

    var $unit = $(this).parents('.unit');
    var $slideshow = $unit.find('.slick-initialized');
    var $slides = $unit.find('.slick-slide:not(.slick-cloned)');
    var $floorplan_slides = $slides.filter(function() {
      return $(this).find('.floor-plan').length
    });

    var index = $floorplan_slides.first().index() - 1;

    $slideshow.slick('slickGoTo', index);
  });
});

$(document).one('ready', function() {
  remove_class_on_body_click('is-open', '.compare');
});
