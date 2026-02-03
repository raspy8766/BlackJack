class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    cards = [0...52]

    # Fisher-Yates shuffle with crypto.getRandomValues
    i = cards.length
    while i > 0
      randIndex = Math.floor(Math.random() * i)

      if window.crypto and window.crypto.getRandomValues
        array = new Uint32Array(1)
        window.crypto.getRandomValues(array)
        randIndex = array[0] % i

      i--
      temp = cards[i]
      cards[i] = cards[randIndex]
      cards[randIndex] = temp

    @add _(cards).map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

  dealPlayer: -> 
    new Hand [@pop(), @pop()], @


  dealDealer: -> new Hand [@pop().flip(), @pop()], @, true
