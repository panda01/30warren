$(function() {
  $('.views').subsection_slideshow('.amenity');
  $('.amenities').subsection_slideshow('.amenity');
  $('.amenity .image').closest('.amenity')
    .resize_to_window_height({ minimum: 300, attr: 'min-height' });
  $('.amenity .image')
    .resize_to_window_height({ minimum: 300 });
});
