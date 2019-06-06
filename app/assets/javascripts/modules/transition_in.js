class TransitionIn {
  constructor ($element) {
    this.$element = $element;
  }

  addClass (className) {
    const $element = this.$element;

    this.$element.addClass(className);

    new Waypoint.Inview({
      element: this.$element.get(0),
      enter: function () {
        this.destroy();
        $element.removeClass(className);
      }
    });
  }
}

module.exports = TransitionIn;
