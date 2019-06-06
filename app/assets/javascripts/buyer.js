//= require jquery
//= require jquery_ujs
//= require jquery-ui/draggable
//= require jquery.waypoints
//= require waypoints.sticky
//= require jquery.sticky
//= require slick
//= require pano2vr_player
//
//= require buyer/lightbox
//= require buyer/resize_to_window_height
//= require buyer/base
//= require buyer/floor_plan_zoom
//= require buyer/legalese
//= require buyer/scroll_to
//= require buyer/remove_class_on_body_click
//= require buyer/subsection_slideshow
//= require buyer/jump_links
//= require buyer/header
//= require buyer/slideshows
//
//= require_tree ./buyer/sections

require('mapbox.js');

const K = require('kefir');

const pages = require('./pages/index');
const syncScale = require('./buyer/modules/sync_scale');

$(function () {
  pages.neighborhood.setup();
});

const lightboxVisibility = K.fromPoll(100, () => $("#lightbox").is(":visible"))
                              .toProperty().skipDuplicates();

syncScale('.units .floor-plan .image-proxy');
syncScale('.comparitor .floor-plan .image-proxy', lightboxVisibility);
