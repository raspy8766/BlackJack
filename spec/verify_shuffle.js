const assert = require('assert');

// Mock browser environment
global.window = global;

// Ensure crypto is available
if (!global.crypto) {
  try {
    global.crypto = require('crypto').webcrypto;
  } catch (e) {
    console.error('Crypto not available');
    process.exit(1);
  }
}
window.crypto = global.crypto;

// Mock dependencies
const _ = require('underscore');
global._ = _;
const Backbone = require('backbone');
global.Backbone = Backbone;

// Mock Card model (simplified)
global.Card = Backbone.Model.extend({
  initialize: function(attributes) {
    this.set(attributes);
  }
});
window.Card = global.Card;

// Load the compiled Deck
// Path is relative to this file
require('../compiled/src/collections/Deck.js');

try {
  console.log('Initializing Deck...');
  const deck = new window.Deck();

  console.log(`Deck length: ${deck.length}`);
  assert.strictEqual(deck.length, 52, 'Deck should have 52 cards');

  const uniqueCards = new Set(deck.map(c => `${c.get('rank')}-${c.get('suit')}`));
  console.log(`Unique cards: ${uniqueCards.size}`);
  assert.strictEqual(uniqueCards.size, 52, 'Deck should have 52 unique cards');

  // Check strict randomness (not just sorted)
  // Reconstruct sorted deck
  const sortedDeck = [];
  for (let i = 0; i < 52; i++) {
    sortedDeck.push(`${i % 13}-${Math.floor(i / 13)}`);
  }

  const currentDeck = deck.map(c => `${c.get('rank')}-${c.get('suit')}`);
  const isSorted = currentDeck.every((val, index) => val === sortedDeck[index]);

  assert.strictEqual(isSorted, false, 'Deck should be shuffled');
  console.log('Deck is shuffled.');

  console.log('Verification passed!');
} catch (error) {
  console.error('Verification failed:', error);
  process.exit(1);
}
