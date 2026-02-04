class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    cards = [0...52]

    # Fisher-Yates shuffle with crypto.getRandomValues if available
    length = cards.length

    while length > 0
      length--
      if window.crypto and window.crypto.getRandomValues
        randomBuffer = new Uint32Array(1)
        window.crypto.getRandomValues(randomBuffer)
        # Modulo bias is negligible for range 52
        randomIndex = randomBuffer[0] % (length + 1)
      else
        randomIndex = Math.floor(Math.random() * (length + 1))

      # Swap
      temp = cards[length]
      cards[length] = cards[randomIndex]
      cards[randomIndex] = temp

    @add _.map cards, (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

  dealPlayer: -> 
    new Hand [@pop(), @pop()], @


  dealDealer: -> new Hand [@pop().flip(), @pop()], @, true
