class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    cards = [0...52]

    # Secure Fisher-Yates shuffle using window.crypto
    for i in [cards.length - 1..1]
      randomBuffer = new Uint32Array(1)
      (window.crypto or window.msCrypto).getRandomValues(randomBuffer)
      # Map random value to index j where 0 <= j <= i
      j = randomBuffer[0] % (i + 1)

      [cards[i], cards[j]] = [cards[j], cards[i]]

    @add _(cards).map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

  dealPlayer: -> 
    new Hand [@pop(), @pop()], @


  dealDealer: -> new Hand [@pop().flip(), @pop()], @, true
