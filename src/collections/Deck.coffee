class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    @add @shuffle([0...52]).map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

  shuffle: (array) ->
    m = array.length
    while m
      i = Math.floor(@random() * m--)
      [array[m], array[i]] = [array[i], array[m]]
    array

  random: ->
    buffer = new Uint32Array(1)
    window.crypto.getRandomValues(buffer)
    buffer[0] / (0xffffffff + 1)

  dealPlayer: -> 
    new Hand [@pop(), @pop()], deck: @


  dealDealer: -> new Hand [@pop().flip(), @pop()], deck: @, isDealer: true

