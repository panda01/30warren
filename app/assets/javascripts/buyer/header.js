$(function() {
  var $floatingFooter = $('.floating-footer');
  var $floatingContent = $('.floating-content');

  $floatingContent.sticky();

  $('.logo').on('click', function() {
    scroll_to(0);
  });

  // Poor man's events!
  setInterval(function () {
    var isStuck = $floatingContent.hasClass('stuck');

    $floatingFooter.toggleClass('is-available', isStuck);
    $floatingFooter.find('.logomark').toggleClass('is-shown', isStuck);
  }, 200)
});
