const sum = require('ramda/src/sum');


class Accordion {
  constructor(options) {
    this.$sections = $(options.sectionSelector);
    this.$labels = $(options.labelSelector);
    this.$contents = $(options.contentSelector);

    this.maxHeight = Infinity;

    $(document).on('click', options.labelSelector, (event) => {
      const $section = $(event.target).closest(options.sectionSelector)
      const $content = $section.find(options.contentSelector);

      if ($section.is('.open')) {
        $section.removeClass('open');
        $content.slideUp();
      } else {
        $(options.sectionSelector).not($section).removeClass('open');
        $(options.contentSelector).not($content).slideUp();
        $section.addClass('open');
        $content.slideDown();
      }
    });
  }

  set maxHeight(value) {
    const headersHeight = sum(this.$labels.map(function (i, el) {
      return $(el).outerHeight();
    }));

    this.$contents.css({
      maxHeight: value - headersHeight
    });
  }
}

module.exports = Accordion;
