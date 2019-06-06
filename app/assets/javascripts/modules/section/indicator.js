class Indicator {
  constructor(s, options = {}) {
    this.background = s.rect(0, 580, '100%', 29).attr({
      fill: "#3A3A3A",
      fillOpacity: 0.15,
      mask: options.mask
    });

    s.paper.select('#Background').after(this.background);
  }

  animate() {
    this.background.animate.apply(this.background, arguments);
  }

  get y () {
    return this.background.attr('y');
  }
}

module.exports = Indicator;
