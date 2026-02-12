class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, options) ->
    @deck = options.deck
    @isDealer = options.isDealer

  hit: ->
    if @isDealer
      if @scores() < 17
        @add(@deck.pop())
        @trigger 'hit'
        @isBusted()
        @hit()
      else
        @stand()
    else
      card = @deck.pop()
      @add(card)
      @trigger 'hit'
      @isBusted()
      card
      



  stand: ->
    @trigger 'stand'


  hasAce: -> 
    @reduce (memo, card) ->
      memo or card.get('value') is 1
    , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    scoreArr = [@minScore(), @minScore() + 10 * @hasAce()]
    if scoreArr[1] > 21 then score = scoreArr[0] else score = scoreArr[1]
    return score

  
  isBusted: ->
    score =  @scores() 
    @trigger('bust') if score > 21
