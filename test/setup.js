
require('coffeescript/register');
const { JSDOM } = require('jsdom');
const dom = new JSDOM('<!DOCTYPE html><html><body></body></html>');

global.window = dom.window;
global.document = dom.window.document;
global.navigator = dom.window.navigator;

// Set up jQuery
const $ = require('jquery')(global.window);
global.jQuery = $;
global.$ = $;

// Set up Underscore
global._ = require('underscore');

// Set up Backbone
const Backbone = require('backbone');
global.Backbone = Backbone;
Backbone.$ = $;

// Load source files
// We need to ensure that classes defined on window are available globally
// because other files reference them directly (e.g. model: Card).

require('../src/models/Card.coffee');
global.Card = window.Card;

require('../src/collections/Hand.coffee');
global.Hand = window.Hand;

require('../src/collections/Deck.coffee');
global.Deck = window.Deck;
