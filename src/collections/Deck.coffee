class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    cards = [0...52]

    # Secure Fisher-Yates shuffle
    i = cards.length
    randBuffer = new Uint32Array(1)

    while i > 0
      window.crypto.getRandomValues(randBuffer)
      # Simple modulo is slightly biased but much better than Math.random()
      # For a perfect distribution, rejection sampling would be needed
      j = randBuffer[0] % i
      i--
      [cards[i], cards[j]] = [cards[j], cards[i]]

    @add cards.map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

  dealPlayer: -> 
    new Hand [@pop(), @pop()], @


  dealDealer: -> new Hand [@pop().flip(), @pop()], @, true
