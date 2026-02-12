const jsdom = require("jsdom");
const { JSDOM } = jsdom;
const { webcrypto } = require('crypto');

const dom = new JSDOM('<!doctype html><html><body></body></html>', {
  url: "http://localhost"
});
global.window = dom.window;
global.document = dom.window.document;
global.navigator = dom.window.navigator;

// Polyfill crypto if not present
if (!global.window.crypto) {
  if (webcrypto) {
     global.window.crypto = webcrypto;
  } else {
     try {
       global.window.crypto = require('crypto').webcrypto;
     } catch (e) {
       console.warn("Could not polyfill window.crypto");
     }
  }
}

if (!global.window.crypto || !global.window.crypto.getRandomValues) {
    const nodeCrypto = require('crypto');
    global.window.crypto = {
        getRandomValues: function(buffer) {
            return nodeCrypto.randomFillSync(buffer);
        }
    };
}

global.jQuery = require('jquery');
global.$ = global.jQuery;
global._ = require('underscore');
global.Backbone = require('backbone');
global.Backbone.$ = global.$;
global.chai = require('chai');
global.sinon = require('sinon');

const path = require('path');
const src = path.resolve(__dirname, '../src');

// Load source files and expose them to global scope
require(path.join(src, 'models/Card.coffee'));
global.Card = window.Card;

require(path.join(src, 'collections/Hand.coffee'));
global.Hand = window.Hand;

require(path.join(src, 'collections/Deck.coffee'));
global.Deck = window.Deck;

require(path.join(src, 'models/App.coffee'));
global.App = window.App; // Assuming App.coffee defines window.App

require(path.join(src, 'views/CardView.coffee'));
global.CardView = window.CardView;

require(path.join(src, 'views/HandView.coffee'));
global.HandView = window.HandView;

require(path.join(src, 'views/AppView.coffee'));
global.AppView = window.AppView;
