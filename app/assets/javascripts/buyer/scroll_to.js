var scroll_to = function(offset, duration) {
  var body = $('html, body')
  var animation = body.data('animated', true)
                      .animate({ scrollTop: offset }, { duration: duration })
                      .promise();

  animation.done(function() {
    setTimeout(function() {
      body.data('animated', false);
    }, 10);
  });
};

var offset_from_hash = function(hash) {
  var element = $(hash);
  if (element.length) {
    return element.offset().top - get_header_height() + 3;
  }
};

var get_header_height = function() {
  return $('.floating-header').outerHeight();
};
