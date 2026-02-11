const jsdom = require("jsdom");
const { JSDOM } = jsdom;
const fs = require('fs');
const path = require('path');
const chai = require('chai');

const dom = new JSDOM('<!DOCTYPE html><html><body></body></html>', {
  url: "http://localhost/",
  runScripts: "dangerously",
  resources: "usable"
});

global.window = dom.window;
global.document = dom.window.document;
global.navigator = dom.window.navigator;

// Load libraries
const libPath = path.resolve(__dirname, '../lib');
const compiledPath = path.resolve(__dirname, '../compiled');

// Helper to load script content into JSDOM
function loadScript(filepath) {
  try {
    const content = fs.readFileSync(filepath, 'utf-8');
    dom.window.eval(content);
  } catch (e) {
    console.error(`Error loading script: ${filepath}`, e);
  }
}

// Load vendored libraries
loadScript(path.join(libPath, 'jquery.js'));
loadScript(path.join(libPath, 'underscore.js'));
loadScript(path.join(libPath, 'backbone.js'));

// Load application code in dependency order
// Models & Collections
loadScript(path.join(compiledPath, 'src/models/Card.js'));
loadScript(path.join(compiledPath, 'src/collections/Hand.js'));
loadScript(path.join(compiledPath, 'src/collections/Deck.js'));
loadScript(path.join(compiledPath, 'src/models/App.js'));

// Views
loadScript(path.join(compiledPath, 'src/views/CardView.js'));
loadScript(path.join(compiledPath, 'src/views/HandView.js'));
loadScript(path.join(compiledPath, 'src/views/AppView.js'));

// Expose globals for tests
global.Deck = dom.window.Deck;
global.Hand = dom.window.Hand;
global.Card = dom.window.Card;
global.App = dom.window.App;
global.CardView = dom.window.CardView;
global.HandView = dom.window.HandView;
global.AppView = dom.window.AppView;
global.$ = dom.window.$;
global._ = dom.window._;
global.Backbone = dom.window.Backbone;

// Setup Chai
global.chai = chai;
global.assert = chai.assert;
global.expect = chai.expect;
