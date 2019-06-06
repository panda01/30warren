function stick(element) {
  new Waypoint.Sticky({
    element: element.get(0),
    offset: 0,
    handler: function (direction) {
      element.toggleClass('stuck', direction === 'down')
    }
  });
}

module.exports = stick;
