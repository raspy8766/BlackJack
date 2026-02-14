
require('./setup');
const { expect } = require('chai');

describe('Deck', () => {
  it('should have 52 cards', () => {
    const deck = new window.Deck();
    expect(deck.length).to.equal(52);
  });

  it('should not contain duplicates', () => {
    const deck = new window.Deck();
    const unique = new Set();
    deck.each(card => {
      unique.add(card.get('rank') + '-' + card.get('suit'));
    });
    expect(unique.size).to.equal(52);
  });

  it('should be shuffled', () => {
    // Generate two decks and verify they are not in the same order.
    // Given the small probability of two shuffles being identical (1/52!), this is safe.
    const deck1 = new window.Deck();
    const deck2 = new window.Deck();

    let different = false;
    for (let i = 0; i < 52; i++) {
      if (deck1.at(i).get('rank') !== deck2.at(i).get('rank') ||
          deck1.at(i).get('suit') !== deck2.at(i).get('suit')) {
        different = true;
        break;
      }
    }
    expect(different).to.be.true;
  });
});
