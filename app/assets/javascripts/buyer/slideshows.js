(function() {
  var resizeSlideshows = function() {
    $('.slick-initialized').each(function() {
      var $slideshow = $(this);

      setTimeout(function() {
        $slideshow.slick('getSlick')
                  .setPosition();
      }, 20);
    });
  };

  $(window).on('resize', resizeSlideshows);
})();
