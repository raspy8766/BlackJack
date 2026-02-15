const { JSDOM } = require('jsdom');
const fs = require('fs');
const path = require('path');

// Setup JSDOM
const dom = new JSDOM('<!doctype html><html><body></body></html>', {
  url: "http://localhost/",
  pretendToBeVisual: true
});
global.window = dom.window;
global.document = dom.window.document;
global.navigator = dom.window.navigator;

// Load libraries
global.$ = global.jQuery = require('jquery');
global._ = require('underscore');
global.Backbone = require('backbone');
global.Backbone.$ = global.$;

// Setup Chai
const chai = require('chai');
global.chai = chai; // Expose chai globally
global.assert = chai.assert;
global.expect = chai.expect;

// Load source files in order
require('../compiled/src/models/Card.js');
global.Card = window.Card;

require('../compiled/src/collections/Hand.js');
global.Hand = window.Hand;

require('../compiled/src/collections/Deck.js');
global.Deck = window.Deck;
