class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    cards = [0...52]
    # Fisher-Yates shuffle using window.crypto for secure randomness
    for i in [cards.length - 1..1]
      rand = new Uint32Array(1)
      window.crypto.getRandomValues(rand)
      j = rand[0] % (i + 1)
      [cards[i], cards[j]] = [cards[j], cards[i]]

    @add cards.map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

  dealPlayer: -> 
    new Hand [@pop(), @pop()], @


  dealDealer: -> new Hand [@pop().flip(), @pop()], @, true

