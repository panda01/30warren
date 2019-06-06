const K = require('kefir');
const compose = require('ramda/src/compose');
const max = require('ramda/src/max');
const min = require('ramda/src/min');
const reduce = require('ramda/src/reduce');
const divide = require('ramda/src/divide');

const arrayMax = reduce(max, -Infinity);

const ready = K.fromEvents($(document), 'ready');
const resize = K.fromEvents(window, 'resize');
const redraw = ready.merge(resize);

module.exports = function (selector, resample = K.never()) {
  const recapture = redraw.merge(resample);

  const elements = ready.merge(resample).map(function () {
    return $(selector);
  });

  const maxOriginalWidth = elements.map(function ($floorplans) {
    return arrayMax($floorplans.map((i, f) => $(f).data('original-width')));
  }).toProperty().skipDuplicates();

  const maxOriginalHeight = elements.map(function ($floorplans) {
    return arrayMax($floorplans.map((i, f) => $(f).data('original-height')));
  }).toProperty().skipDuplicates();

  const maxFloorplanWidth = elements.sampledBy(recapture).map(function ($floorplans) {
    return arrayMax($floorplans.map((i, f) => $(f).outerWidth()));
  }).toProperty().skipDuplicates();

  const maxFloorplanHeight = elements.sampledBy(recapture).map(function ($floorplans) {
    return arrayMax($floorplans.map((i, f) => $(f).outerHeight()));
  }).toProperty().skipDuplicates();

  const widthRatio = K.combine([maxFloorplanWidth, maxOriginalWidth], divide);
  const heightRatio = K.combine([maxFloorplanHeight, maxOriginalHeight], divide);
  const floorplanRatio = K.combine([widthRatio, heightRatio], min);

  floorplanRatio.onValue(function (ratio) {
    const floorplans = $(selector);

    floorplans.each(function () {
      const plan = $(this);
      const width = $(this).data('original-width');
      const height = $(this).data('original-height');
      const backgroundSize = `${Math.floor(ratio * width)}px ${Math.floor(ratio * height)}px`

      plan.css({ backgroundSize });
    });
  });

  maxOriginalHeight.onValue(function (maxHeight) {
    const floorplans = $(selector);

    floorplans.each(function () {
      const plan = $(this);
      const height = $(this).data('original-height');
      const zoom = `${height / maxHeight * 70}%`;

      plan.find('img').css({ maxHeight: zoom });
    });
  });

  maxOriginalWidth.onValue(function (maxWidth) {
    const floorplans = $(selector);

    floorplans.each(function () {
      const plan = $(this);
      const width = $(this).data('original-width');
      const zoom = `${width / maxWidth * 70}%`;

      plan.find('img').css({ maxWidth: zoom });
    });
  });

  return {
    elements,
    maxOriginalWidth,
    maxOriginalHeight,
    maxFloorplanWidth,
    maxFloorplanHeight,
    widthRatio,
    heightRatio,
    floorplanRatio,
  }
}
