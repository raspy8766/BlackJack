class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    cards = [0...52]
    @secureShuffle(cards)
    @add _(cards).map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

  secureShuffle: (array) ->
    currentIndex = array.length

    if window.crypto and window.crypto.getRandomValues
      randomValues = new Uint32Array(currentIndex)
      window.crypto.getRandomValues(randomValues)

    while currentIndex != 0
      if randomValues
        randomIndex = randomValues[currentIndex - 1] % currentIndex
      else
        randomIndex = Math.floor(Math.random() * currentIndex)

      currentIndex--

      temporaryValue = array[currentIndex]
      array[currentIndex] = array[randomIndex]
      array[randomIndex] = temporaryValue

    array

  dealPlayer: -> 
    new Hand [@pop(), @pop()], @


  dealDealer: -> new Hand [@pop().flip(), @pop()], @, true
