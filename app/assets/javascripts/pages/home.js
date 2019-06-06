const createDocument = require('../modules/create_document');
const stick = require('../modules/stick');

let home = {
  setup: function () {
    const $homeHeader = $('.home-header');
    const $homeHeroContainer = $('.home-hero-container');

    new Waypoint({
      element: $homeHeroContainer.get(0),
      offset: function () {
        return -$homeHeroContainer.height() + $homeHeader.height();
      },
      handler: function (direction) {
        $homeHeader.toggleClass('stuck', direction === 'down')
      }
    });

    const $firstNavigationLink = $('nav a').first();
    const firstNavigationLinkHref = $firstNavigationLink.attr('href');

    $.get(firstNavigationLinkHref).then((data) => {
      const $doc = $(createDocument(data));

      $doc.find('footer, #lightbox').remove();

      const $firstPage = $('<div class="dummy-first-page">')
        .append($doc.find('body').html())
        .insertAfter($('.wrapper'));

      new Waypoint({
        element: $firstPage.get(0),
        handler: function (direction) {
          history.pushState({}, $doc.find('title').text(), firstNavigationLinkHref);
          this.destroy();
        }
      });

      stick($firstPage.find('.header'));

      $(document).trigger('page:load');
    });
  }
};

module.exports = home;
