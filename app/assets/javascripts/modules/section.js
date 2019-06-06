const Snap = require('snapsvg');

const filter = require('ramda/src/filter');
const gte = require('ramda/src/gte');
const where = require('ramda/src/where');
const prop = require('ramda/src/prop');
const sum = require('ramda/src/sum');
const map = require('ramda/src/map');
const propEq = require('ramda/src/propEq');
const find = require('ramda/src/find');
const compose = require('ramda/src/compose');
const times = require('ramda/src/times');
const add = require('ramda/src/add');
const reduce = require('ramda/src/reduce');

const Indicator = require('./section/indicator');

const totalHeight = compose(sum, map(prop('height')));

class MissingUnit {
  constructor (section) {
    this.left = 0;
    this.width = section.width;
  }
}

class Section {
  constructor(selector, floors) {
    this.s = new Snap(selector);
    this.floors = floors;
    this.height = totalHeight(floors);
    this.width = 594.82;

    this.clippingPath = this.s.select('#clipping-path').attr({
      fill: "white"
    });

    this.indicator = new Indicator(this.s, {
      mask: this.clippingPath
    });
  }

  indicateUnit(floor, letter) {
    this.indicator.animate({
      x:      this.unitOffset(floor, letter),
      y:      this.floorOffset(floor),
      width:  this.unitWidth(floor, letter),
      height: this.unitHeight(floor, letter),
    }, this.durationTo(floor), mina.easeinout);
  }

  durationTo(floor) {
    const offset = this.floorOffset(floor);
    const currentOffset = this.indicator.y;
    const distance = Math.abs(offset - currentOffset);

    return 300 + distance * 2;
  }

  floorWithFloorsBelow(floor) {
    return filter(where({ floor: gte(floor) }), this.floors);
  }

  floorOffset(floor) {
    const distanceFromBottom = sum(map(prop('height'), this.floorWithFloorsBelow(floor)));

    return this.height - distanceFromBottom;
  }

  floorHeight(number) {
    return prop('height', this.floor(number));
  }

  floorUnits(number) {
    return this.floor(number).units || {};
  }

  floor(number) {
    return find(propEq('floor', number), this.floors)
  }

  unitOffset(floor, letter) {
    return this.unit(floor, letter).left || 0
  }

  unitFloors(floor, letter) {
    const numberOfFloors = this.unit(floor, letter).floors || 1;
    return times(add(floor), numberOfFloors);
  }

  unitWidth(floor, letter) {
    return this.unit(floor, letter).width || this.width
  }

  unitHeight(floor, letter) {
    const sumOfHeights = compose(sum, map(this.floorHeight.bind(this)));
    return sumOfHeights(this.unitFloors(floor, letter));
  }

  unit(number, letter) {
    return this.floorUnits(number)[letter] || new MissingUnit(this);
  }
}

module.exports = Section;
