const Accordion = require('../modules/accordion');

const HOME_SLUG = '30-warren';
const CENTER = [40.71457, -74.00804];

let places = {
  setup: function () {
    let map = this.map = this.setupMap();

    if (typeof map !== "undefined") {
      this.setupMarkers(map, window.mapPlaces);
      this.setupNav();
    }
  },

  setupMap: function () {
    if (!$('#places-map').length) return;

    const southWest = L.latLng(40.701073, -74.040967);
    const northEast = L.latLng(40.765795, -73.957957);
    const bounds = L.latLngBounds(southWest, northEast);

    if (document.body.clientWidth < 1400) {
      var initialZoom = 15;
    } else {
      var initialZoom = 16;
    }

    let map = L.map('places-map', {
      maxBounds: bounds,
      zoomControl: false,
      maxZoom: 16,
      minZoom: 15,
      zoom: initialZoom
    });

    L.mapbox.styleLayer('mapbox://styles/noeassociates/ciihvkynq00108tm0vi4wyk4r')
      .addTo(map);

    map.setView(CENTER, initialZoom);
    map.keyboard.disable();
    map.scrollWheelZoom.disable();

    new L.Control.Zoom({ position: 'topright' }).addTo(map);

    return map;
  },

  setupMarkers: function (map, places) {
    this.markers = {};
    this.markerLayer = L.mapbox.featureLayer().addTo(map);

    this.markerLayer.on('layeradd', e => {
      const marker = e.layer;
      const feature = marker.feature;
      const slug = marker.feature.properties.slug;

      marker.setIcon(L.icon(feature.properties.icon));

      if (slug === HOME_SLUG) {
        marker.unbindPopup();
      } else {
        let markerContent = marker._popup._content +
          `<a class="place-map-close-button" data-slug="${slug}">
            &times;
          </a>`;

        if (marker.feature.properties.aliases) {
          let aliases = marker.feature.properties.aliases;
          let aliasesHtml = aliases.split("\n").join("<br>\n");

          markerContent += `<div class="marker-aliases">${aliasesHtml}</div>`;
        }

        marker.bindPopup(markerContent, { closeButton: false });
      }

      this.markers[slug] = marker;
    });

    map.on('zoomend', () => {
      var currentZoom = map.getZoom();
      var maxZoom = map.getMaxZoom();
      var ratio = currentZoom / maxZoom;
      var size = window.ICONS.Footprint.iconSize
      var anchor = window.ICONS.Footprint.iconAnchor
      var icon = $.extend({}, window.ICONS.Footprint, {
        iconSize:   [  size[0] * ratio,   size[1] * ratio],
        iconAnchor: [anchor[0] * ratio, anchor[1] * ratio]
      });

      this.markers['30-warren'].setIcon(L.icon(icon));
    });

    let features = places.map(p => this.createMarkerJSON(p));

    features.push({
      type: 'Feature',
      properties: {
        slug: '30-warren',
        icon: window.ICONS.Footprint
      },
      geometry: {
        type: 'Point',
        coordinates: [CENTER[1], CENTER[0]]
      },
    });

    this.markerLayer.setGeoJSON({
      type: 'FeatureCollection',
      features
    });
  },

  createMarkerJSON: function (place) {
    let icon = window.ICONS[place.category] || window.ICONS['dot'];

    if (place.category == "Home") {
      // TODO: Not sure why this needs to be reversed. Inconsistent API?
      var coordinates = [CENTER[1], CENTER[0]];
    } else {
      var coordinates = [
        parseFloatToFixed(7, place.long),
        parseFloatToFixed(7, place.lat)
      ];
    }

    return {
      type: 'Feature',
      properties: {
        title: place.name,
        description: place.address,
        slug: place.slug,
        aliases: place.aliases,
        icon
      },
      geometry: {
        type: 'Point',
        coordinates: coordinates
      },
    }
  },

  setupNav: function () {
    let $map = $('#places-map');

    let navigation = new Accordion({
      labelSelector: '.places-nav-section-label',
      sectionSelector: '.places-nav-section',
      contentSelector: '.places-nav-section-places'
    });

    navigation.maxHeight = $map.height();

    $(window).on('resize', () => {
      navigation.maxHeight = $map.height();
    });

    $('.places-nav-place').on('click',
      e => this.setActiveMarker($(e.currentTarget).data('slug'))
    );

    $(document).on('click', '.place-map-close-button', e => {
      let slug = $(e.currentTarget).data('slug');
      this.markers[slug].closePopup();
    });
  },

  setActiveMarker: function (slug) {
    const marker = this.markers[slug];

    for (let key in this.markers) {
      if (key !== slug) this.markers[key].closePopup();
    }

    $('.places-nav-place').removeClass('active');
    $(`.places-nav-place[data-slug=${slug}]`).addClass('active');

    if (slug !== HOME_SLUG) {
      marker.openPopup();
    }

    this.map.panTo(marker.getLatLng());
  }
}

function parseFloatToFixed(positions, floatish) {
  return +parseFloat(floatish).toFixed(positions);
}

module.exports = places;
