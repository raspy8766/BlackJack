class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    cards = [0...52]
    # Fisher-Yates shuffle with crypto.getRandomValues
    i = cards.length
    while --i > 0
      rand = window.crypto.getRandomValues(new Uint32Array(1))[0]
      j = rand % (i + 1)
      [cards[i], cards[j]] = [cards[j], cards[i]]

    @add _(cards).map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

  dealPlayer: -> 
    new Hand [@pop(), @pop()], @


  dealDealer: -> new Hand [@pop().flip(), @pop()], @, true
