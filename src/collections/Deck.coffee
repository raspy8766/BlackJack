class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    # Create an array of 52 card indices
    cards = [0...52]

    # Secure Fisher-Yates Shuffle
    i = cards.length
    while --i > 0
      j = @secureRandom(i + 1)
      [cards[i], cards[j]] = [cards[j], cards[i]]

    @add _(cards).map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

  secureRandom: (max) ->
    # Generate a random integer in [0, max)
    array = new Uint32Array(1)
    # Rejection sampling to avoid modulo bias
    # We want a number in [0, limit) where limit is the largest multiple of max <= 2^32
    limit = 4294967296 - (4294967296 % max)

    loop
      window.crypto.getRandomValues(array)
      break if array[0] < limit

    array[0] % max

  dealPlayer: -> 
    new Hand [@pop(), @pop()], @


  dealDealer: -> new Hand [@pop().flip(), @pop()], @, true
