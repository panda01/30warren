App = {
  set_global : function(key, value) {
    var site = this;

    var set = function() {
      site[key] = value;
    };

    set();

    if (typeof Turbolinks !== "undefined") {
      $(document).on(Turbolinks.EVENTS.BEFORE_UNLOAD, set);
    }
  },

  when_mobile: function(fn) {
    App.mobile_callbacks.push(fn);
  },

  when_desktop: function(fn) {
    App.desktop_callbacks.push(fn);
  },

  run_callbacks: function(key) {
    $.each(App[key + '_callbacks'], function(i, callback) {
      callback();
    });
  }
};

App.set_global('slide_speed', 700);
App.set_global('mobile_callbacks', []);
App.set_global('desktop_callbacks', []);

Layout = {
  width : window.outerWidth == 0 ? 960 : window.outerWidth,

  Desk : {
    name          : 'desktop',
    min_width     : 768
  },

  Hand : {
    name          : 'mobile',
    min_width     : 0,
    max_width     : 767
  },

  get_breakpoint: function () {
    this.width = $(window).width();

    var breakpoints = ['Hand', 'Desk'];

    for (var i=0; i < breakpoints.length; i++) {
      var breakpoint     = breakpoints[i],
          min_width      = this[breakpoint].min_width,
          max_width      = this[breakpoint].max_width,
          is_at_open_end = (i == breakpoints.length - 1 && typeof max_width == 'undefined');

      if (this.width >= min_width && (is_at_open_end || this.width <= max_width)) {
        return this[breakpoint];
      }
    }

    return { name: '<Unknown>' };
  },

  on_new_breakpoint: function () {
    var current_breakpoint = this.get_breakpoint();

    return this.breakpoint.name !== current_breakpoint.name;
  }
};

Layout.breakpoint = Layout.get_breakpoint();

$(function() {
  setTimeout(do_resize, 1);
  setInterval(do_resize, 500);

  $(window).on('focus', do_resize);
  $(window).on('resize', do_resize);

  setTimeout(function() {
    App.run_callbacks(Layout.breakpoint.name);
  }, 1);
});

function do_resize() {
  if (Layout.on_new_breakpoint()) {
    Layout.breakpoint = Layout.get_breakpoint();

    App.run_callbacks(Layout.breakpoint.name);
  }
}
