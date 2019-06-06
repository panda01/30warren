$(function() {
  $('.legal-button, .legal a').click(function(event) {
    event.preventDefault();

    var $legalese = $('.legalese');

    if (!$legalese.hasClass('show')) {
      $legalese.scrollTop(0);
    }

    $legalese.toggleClass('show');
  });
});
