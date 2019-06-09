//= require jquery
//= require jquery_ujs
//= require jquery-ui/slider
//= require jquery.waypoints
//= require waypoints.sticky
//= require waypoints.inview
//= require jquery.sticky
//= require slick
//= require pano2vr_player
//= require imagesloaded
//= require js.cookie
//
//= require legacy/scroll_to
//= require legacy/jump_links
//= require legacy/lightbox

require("mapbox.js");

const K = require("kefir");
const sortBy = require("ramda/src/sortBy");
const prop = require("ramda/src/prop");
const head = require("ramda/src/head");
const compose = require("ramda/src/compose");
const map = require("ramda/src/map");
const equals = require("ramda/src/equals");
const complement = require("ramda/src/complement");
const and = require("ramda/src/and");
const not = require("ramda/src/not");
const isnt = complement(equals);

const pages = require("./pages/index");
const TransitionIn = require("./modules/transition_in");
const Slideshow = require("./modules/slideshow");
const stick = require("./modules/stick");
const tick = require("./modules/tick");
const goTo = require("./modules/scroll");
const selfReferential = require("./modules/self_referential");

if (!selfReferential()) {
  $("html").addClass("is-prepped");
}

$(document).one("ready", function() {
  if (pages[window.pageSlug]) pages[window.pageSlug].setup();

  if (window.pageSlug !== "home") stick($(".header"));

  if (!selfReferential()) {
    let $transitionLockup = $('<div class="transition-lockup">');
    let $transitionLogo = $(".logomark")
      .first()
      .clone()
      .addClass("transition-logomark")
      .removeClass("is-shown");

    $transitionLockup.append($transitionLogo);

    $("body").append($transitionLockup);

    setTimeout(function() {
      $transitionLockup.addClass("is-shown");
      $transitionLogo.addClass("is-shown");
    }, 300);

    setTimeout(function() {
      $transitionLockup.removeClass("is-shown");
      $transitionLogo.removeClass("is-shown");
    }, 3500);

    setTimeout(function() {
      $("html")
        .removeClass("is-prepped")
        .addClass("is-transitioning-in");
    }, 5000);
  }

  $(document).on("click", ".menu-toggle", function() {
    $(this)
      .siblings(".main-nav")
      .slideToggle();
  });

  $(".press-decoration").each(function() {
    const $decoration = $(this);
    const $images = $decoration.find(".press-decoration__image");
    const active = K.interval(Math.random() * 3000 + 3000)
      .map(() => Math.floor(Math.random() * $images.length))
      .toProperty(() => 0)
      .skipDuplicates();

    active.onValue(i => {
      $images.removeClass("is-active");
      $images.eq(i).addClass("is-active");
    });
  });
});

$(document).on("ready page:load", function() {
  $(".slideshow-block .slides").each(function() {
    new Slideshow($(this));
  });

  $(
    ".feature-block__text, .text-block, .file-block, .team-block, .image-block__text"
  ).each(function() {
    new TransitionIn($(this)).addClass("is-prepped");
  });

  $(".content-blocks")
    .append('<div class="content-block-paginator is-previous">')
    .append('<div class="content-block-paginator is-next">');

  // TODO: These ga events may be obsolete now that 30 Warren is using Google Tag Manager
  $(".fact-sheet-link").on("click", function() {
    ga("send", "event", "Factsheet", "Download");
  });

  $(".team-member .details a").on("click", function() {
    ga("send", "event", "Team Site", "Click", $(this).attr("href"));
  });

  $('.phone-number, a[href^="tel:"]').on("click", function() {
    ga("send", "event", "Click", "Call");
  });

  $('a[href^="mailto:"]').on("click", function() {
    ga("send", "event", "Click", "Mail");
  });

  $(".press-clipping").on("click", function() {
    ga("send", "event", "View", "Press", $(this).attr("href"));
  });

  $(".floor-plan-pdf a").on("click", function() {
    ga("send", "event", "Floorplan", "Download", $(this).data("door-number"));
  });
});

$(window).on("load", function() {
  Waypoint.refreshAll();
  $("body").addClass("ready");
});

$(document).on("click", ".content-block-paginator", function() {
  var $active = $(".content-block-chunk.is-active");

  if ($(this).hasClass("is-next")) {
    var $target = $active.next();
  } else {
    var $target = $active.prev();
  }

  if ($target.length) {
    goTo($target.offset().top);
  }
});

const firstItem = prop(0);
const secondItem = prop(1);
const sortByFirstItem = sortBy(firstItem);
const firstByFirstItem = compose(head, sortByFirstItem);
const keycode = prop("which");
const keyIs = code => compose(equals(code), keycode);

const click = K.fromEvents($(document), "click");
const resize = K.fromEvents(window, "resize");

const keydown = K.fromEvents($(document), "keydown");
const downKey = keydown.filter(keyIs(40));
const upKey = keydown.filter(keyIs(38));
const leftKey = keydown.filter(keyIs(37));
const rightKey = keydown.filter(keyIs(39));

const scroll = K.fromEvents(window, "scroll").delay(1);
const ready = K.fromEvents($(document), "ready");
const redraw = ready.merge(resize);

const onTeamPage = ready.map(() => $("body").hasClass("the-team")).toProperty();
const onWidescreen = redraw.map(() => $(window).width() > 1000).toProperty();
const horizontalTeamLayout = K.combine([onWidescreen, onTeamPage], and);

const scrollEnd = scroll.debounce(200);
const scrollStart = scroll.debounce(300, { immediate: true });
const scrollPosition = ready
  .merge(scroll)
  .map(function() {
    return $(window).scrollTop() + $(window).height() / 2;
  })
  .toProperty()
  .skipDuplicates();
const positionAfterScroll = scrollPosition.sampledBy(scrollEnd);
const positionAfterReady = scrollPosition.sampledBy(ready);
const updatedPosition = positionAfterScroll
  .merge(positionAfterReady)
  .filterBy(horizontalTeamLayout.map(not));

const currentSection = updatedPosition
  .map(function(position) {
    const windowOffset = $(window).height() / 4;

    return firstByFirstItem(
      map(function(el) {
        return [Math.abs($(el).offset().top + windowOffset - position), el];
      }, $(".content-block-chunk").toArray())
    );
  })
  .filter(isnt(undefined));

const currentSectionInRange = currentSection
  .filter(function(section) {
    return section[0] < $(window).height() / 2;
  })
  .map(secondItem);

const downKeySection = downKey
  .map(function(e) {
    e.preventDefault();

    return $(".content-block-chunk.is-active").next();
  })
  .filter(prop("length"));

const upKeySection = upKey
  .map(function(e) {
    e.preventDefault();

    return $(".content-block-chunk.is-active").prev();
  })
  .filter(prop("length"));

const readMoreClick = click.filter(function(e) {
  return $(e.target).hasClass("read-more");
});

readMoreClick.onValue(e => e.preventDefault());

const readMoreSection = readMoreClick.map(function() {
  return $(".content-block-chunk.is-active").next();
});

const upcomingSection = currentSectionInRange
  .merge(readMoreSection)
  .merge(downKeySection)
  .merge(upKeySection);

const sectionIndex = upcomingSection.map(function(el) {
  const $el = $(el);
  const $blocks = $(".content-block-chunk");

  return $blocks.index($el);
});

const onFirstBlock = sectionIndex.map(equals(0)).toProperty();
const reachedEnd = sectionIndex.map(equals(-1)).toProperty();
const onLastBlock = sectionIndex
  .map(function(index) {
    const $blocks = $(".content-block-chunk");

    return index == $blocks.length - 1;
  })
  .toProperty();

onFirstBlock.onValue(function(isFirst) {
  $(".content-block-paginator.is-previous").toggleClass("is-hidden", isFirst);
});

onLastBlock.onValue(function(isLast) {
  $(".content-block-paginator.is-next").toggleClass("is-hidden", isLast);
});

onLastBlock.onValue(function(isLast) {
  $(".content-blocks .next-page-link").toggleClass("is-shown", isLast);
});

scrollStart.onValue(function() {
  $(".content-blocks .next-page-link").removeClass("is-shown");
});

upcomingSection.onValue(function(el) {
  const $el = $(el);
  const offset = $el.offset().top;

  $(".content-block-chunk")
    .not($el)
    .removeClass("is-active");
  $el.addClass("is-active");

  if ($(window).width() > 767) {
    goTo(offset);
  }
});

leftKey.onValue(function() {
  const $activeChunk = $(".content-block-chunk.is-active");
  const $slideshow = $activeChunk.find(".slick-initialized");

  if ($slideshow.length) {
    $slideshow.slick("slickPrev");
  }
});

rightKey.onValue(function() {
  const $activeChunk = $(".content-block-chunk.is-active");
  const $slideshow = $activeChunk.find(".slick-initialized");

  if ($slideshow.length) {
    $slideshow.slick("slickNext");
  }
});

downKey.filterBy(reachedEnd).onValue(function(event) {
  const $nextLink = $(".content-blocks .next-page-link a");
  const url = $nextLink.attr("href");

  if (typeof url !== "undefined") {
    event.preventDefault();

    window.location.href = url;
  }
});

redraw.onValue(function() {
  $(".image-block.is-full-width.is-contained").each(function(i, el) {
    const $block = $(el);
    const $image = $block.find(".image-block__image");
    const height = $block.data("height");
    const width = $block.data("width");
    const currentHeight = $image.height();
    const ratio = width / height;

    $image.css({
      width: currentHeight * ratio
    });
  });
});
