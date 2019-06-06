const Hammer = require('hammerjs');
const values = require('ramda/src/values');

class Slideshow {
  constructor($el) {
    this.$el = $el;

    let options = {
      prevArrow: '<a class="paginator previous">Previous</a>',
      nextArrow: '<a class="paginator next">Next</a>',
    }

    if (this.isPanorama()) {
      this._cursor = 0;

      this.$tip = $('<div class="slideshow-tip">Reveal More</div>');
      this.$track = $('<div class="slide-track">');
      this.$slides = this.$el.find('.slide');

      this.$track.append(this.$slides);

      this.$el.parent().append(this.$tip);
      this.$el.append(values(options));
      this.$el.append(this.$track);

      this.$next = this.$el.find('.next');
      this.$prev = this.$el.find('.prev');

      this.$prev.addClass('is-disabled');

      this.tipWaypoint = new Waypoint.Inview({
        element: this.$tip.get(0),
        enter: function () {
          $(this.element).addClass('is-shown');
          this.destroy();
        }
      });

      this.pan = new Hammer.Pan();
      this.manager = new Hammer.Manager(this.$track.get(0));
      this.manager.add(this.pan);

      this.manager.on('panstart', (e) => {
        this.$track.removeClass('is-animated');
        this.lastDelta = 0;
      });

      this.manager.on('pan', (e) => {
        const width = $(window).width();
        const movement = -(e.deltaX - this.lastDelta);
        const constraintWidth = width * this.$slides.length;
        const constraintPercentage = movement / constraintWidth;
        const cursorMovement = constraintPercentage * 100;

        this.cursor += cursorMovement;
        this.lastDelta = e.deltaX;
      });

      this.$next.on('click', () => {
        this.withAnimation(() => this.cursor += 20);
      });

      this.$prev.on('click', () => {
        this.withAnimation(() => this.cursor -= 20);
      });

      this.$tip.on('click', () => {
        this.withAnimation(() => this.cursor += 20);
      });

      this.$el.on('beforeChange', () => {
        this.$tip.removeClass('is-shown');
        this.$prev.toggleClass('is-disabled', this.cursor === 0);
        this.$next.toggleClass('is-disabled', this.cursor === 100);
      });

      $(window).on('resize', (event) => {
        this.$slides.width($(event.target).width());
      });

      this.$slides.width($(window).width());
    } else {
      options.fade = true;
      options.autoplay = true;
      options.autoplaySpeed = 4000;

      this.$el.slick(options);
    }
  }

  get cursor() {
    return this._cursor;
  }

  set cursor(value) {
    this._cursor = Math.max(0, Math.min(100, value));
    this.update();
    return this._cursor;
  }

  isPanorama() {
    return this.$el[0].hasAttribute("data-is-panorama");
  }

  update() {
    let max = $(window).width() * (this.$slides.length - 1);
    let left = this.cursor / -100 * max;
    this.$el.trigger('beforeChange');
    this.$track.css({ left });
  }

  withAnimation(fn) {
    this.$track.one('transitionend', function () {
      $(this).removeClass('is-animated');
    });
    this.$track.addClass('is-animated');
    fn();
  }
}

module.exports = Slideshow;
