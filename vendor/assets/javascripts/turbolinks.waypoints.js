(function(wp) {
  if (typeof Turbolinks !== "undefined") {
    $(document).on(Turbolinks.EVENTS.FETCH, function() {
      wp.destroyAll();
    });
  }
})(Waypoint);
