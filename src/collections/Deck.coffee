class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    cards = [0...52]
    # Secure Fisher-Yates shuffle using window.crypto
    buffer = new Uint32Array(cards.length)
    window.crypto.getRandomValues(buffer)

    for i in [cards.length - 1..1]
      j = buffer[i] % (i + 1)
      [cards[i], cards[j]] = [cards[j], cards[i]]

    @add _(cards).map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

  dealPlayer: -> 
    new Hand [@pop(), @pop()], @


  dealDealer: -> new Hand [@pop().flip(), @pop()], @, true

