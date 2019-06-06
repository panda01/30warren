function remove_class_on_body_click(c, selector) {
  var hide_on_body_click = function(event) {
    var close = $(event.target).closest(selector);
    $(selector).not(close).removeClass(c);
  };

  $('body').click(hide_on_body_click);
}
