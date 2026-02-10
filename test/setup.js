const jsdom = require("jsdom");
const { JSDOM } = jsdom;
const path = require('path');

// Setup JSDOM
const dom = new JSDOM("<!DOCTYPE html><html><body></body></html>", {
  url: "http://localhost/"
});
global.window = dom.window;
global.document = dom.window.document;
global.navigator = dom.window.navigator;

// Globals required by libraries
global.$ = global.jQuery = require('jquery')(global.window);
global._ = require('underscore');
global.Backbone = require('backbone');
global.Backbone.$ = global.$;

// Setup testing libraries
global.chai = require('chai');
global.sinon = require('sinon');
// Expose assert globally for specs
global.assert = global.chai.assert;
global.expect = global.chai.expect;

// Polyfill window.crypto for tests if not present
if (!global.window.crypto) {
    if (global.crypto) {
        global.window.crypto = global.crypto;
    } else {
        try {
            const crypto = require('crypto');
            if (crypto.webcrypto) {
                global.window.crypto = crypto.webcrypto;
            } else {
                 global.window.crypto = {
                     getRandomValues: function(buffer) {
                         return crypto.randomFillSync(buffer);
                     }
                 };
            }
        } catch (e) {
            console.error("Crypto polyfill failed", e);
        }
    }
}

// Helper to load compiled source files
function load(file) {
    // resolve relative to project root
    try {
        require(path.resolve(file));
    } catch (e) {
        console.error(`Failed to load ${file}:`, e);
    }
}

// Helper to expose class from window to global
function expose(cls) {
    if (global.window[cls]) {
        global[cls] = global.window[cls];
    } else {
        console.warn(`Warning: ${cls} not found in window object after load.`);
    }
}

// Load Source Files in dependency order and expose them immediately
// 1. Models
load('compiled/src/models/Card.js');
expose('Card');

// 2. Collections (depend on Models)
load('compiled/src/collections/Deck.js');
expose('Deck');

load('compiled/src/collections/Hand.js');
expose('Hand');

// 3. App Model (depends on Collections)
load('compiled/src/models/App.js');
expose('App');

// 4. Views (depend on Models/Collections)
load('compiled/src/views/CardView.js');
expose('CardView');

load('compiled/src/views/HandView.js');
expose('HandView');

load('compiled/src/views/AppView.js');
expose('AppView');
