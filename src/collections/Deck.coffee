class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    cards = [0...52]
    # Secure Fisher-Yates shuffle
    m = cards.length
    while m
      i = Math.floor(window.crypto.getRandomValues(new Uint32Array(1))[0] / 4294967296 * m--)
      [cards[m], cards[i]] = [cards[i], cards[m]]

    @add cards.map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

  dealPlayer: -> 
    new Hand [@pop(), @pop()], { deck: @ }


  dealDealer: -> new Hand [@pop().flip(), @pop()], { deck: @, isDealer: true }

