assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()
    debugger;

  describe 'hit', ->
    it 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 50
      assert.strictEqual deck.last(), hand.hit()
      assert.strictEqual deck.length, 49

  describe 'shuffle', ->
    it 'should be shuffled', ->
      current = deck.map (card) -> card.get('rank') + card.get('suit') * 13

      isOrdered = true
      for i in [0...current.length]
        if current[i] != i
          isOrdered = false
          break
      assert.isFalse isOrdered
