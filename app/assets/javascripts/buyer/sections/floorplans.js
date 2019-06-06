$(function() {
  var $floorplans = $('#floorplans');

  if ($floorplans.find('.unit').length) {
    $floorplans.subsection_slideshow();
  }
});
