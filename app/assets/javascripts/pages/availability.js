const Section = require('../modules/section');
const tick = require('../modules/tick');
const goTo = require('../modules/scroll');

module.exports = {
  setup: function () {
    if ($('.unit-previewer').length) {
      const section = new Section('.building-section__diagram svg', [
        { floor: 12, height: 110 },
        { floor: 11, height:  37 },
        { floor: 10, height:  37 },
        { floor:  9, height:  37, units: { A: { left: 330, width: 240 }                                                                      }},
        { floor:  8, height:  37, units: { A: { left: 180, width: 150, floors: 2}, B: { left: 330, width: 240 }                              }},
        { floor:  7, height:  37, units: { A: { left: 180, width: 150 },           B: { left: 330, width: 265 }                              }},
        { floor:  6, height:  37, units: { A: { left: 180, width: 150 },           B: { left: 330, width:  95 }, C: { left: 425, width: 170 }}},
        { floor:  5, height:  37, units: { A: { left: 180, width: 150 },           B: { left: 330, width:  95 }, C: { left: 425, width: 170 }}},
        { floor:  4, height:  37, units: { A: { left: 180, width: 150 },           B: { left: 330, width: 135 }, C: { left: 465, width: 130 }}},
        { floor:  3, height:  37, units: { A: { left: 180, width: 150 },           B: { left: 330, width: 135 }, C: { left: 465, width: 130 }}},
        { floor:  2, height:  40, units: { A: { left: 180, width: 150 },           B: { left: 330, width: 135 }, C: { left: 465, width: 130 }}},
        { floor:  1, height:  51 }
      ]);

      $('.building-section').addClass('is-loaded');

      $('.unit').on('mouseenter', function() {
        section.indicateUnit($(this).data('floor'), $(this).data('letter'));
      });

      $('.unit').on('click', function (e) {
        if (!$(e.target).is('a')) {
          const $unit = $(this);
          const $units = $('.unit');

          $unit.toggleClass('is-active');
          $units.not($unit).removeClass('is-active');

          if (!$unit.hasClass('is-active')) return;

          tick(function () {
            const offset = $unit.offset().top;
            const height = $unit.outerHeight();
            const scrollTop = $(window).scrollTop();
            const windowHeight = $(window).height();

            if (offset + height > scrollTop + windowHeight) {
              goTo(offset);
            }
          });
        }
      });
    }
  }
}
