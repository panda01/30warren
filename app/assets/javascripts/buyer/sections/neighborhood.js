$(function() {
  $('.places-map-container').resize_to_window_height({ minimum: 300 });

  $('#pano').resize_to_window_height({ minimum: 300 });

  $('.local-features').subsection_slideshow('.amenity');
  $('.local-features .image').resize_to_window_height({ minimum: 300 });
});
