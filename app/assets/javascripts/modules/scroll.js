const s = function(offset) {
  const scrollPosition = offset - s.topOffset();

  s.withoutOffset(scrollPosition);
};

const scrollEvents = [
  "scroll",
  "mousedown",
  "wheel",
  "DOMMouseScroll",
  "mousewheel",
  "keyup",
  "touchmove"
].join(" ");

s.topOffset = function() {
  return $(".header").height();
};

s.withoutOffset = function(scrollPosition) {
  if ($(window).scrollTop() !== scrollPosition) {
    const $body = $("html, body");
    const stopScroll = () => $body.stop();

    $body.on(scrollEvents, stopScroll);

    $body.stop().animate(
      {
        scrollTop: scrollPosition
      },
      400,
      () => $body.off(scrollEvents, stopScroll)
    );
  }
};

module.exports = s;
