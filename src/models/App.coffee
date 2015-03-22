# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'all', @playerEvents, @
    @get('dealerHand').on 'all', @dealerEvents, @    
      
  playerEvents: (event, hand) ->
    switch event
      when 'bust' then @trigger 'dealer-wins'
      when 'stand' then @get('dealerHand').hit()

  dealerEvents: (event, hand) ->
    switch event
      when 'bust' then @trigger 'player-wins'
      when 'stand' then @compareScores()



  compareScores: ->
    if @get('dealerHand').scores() < 22 && @get('playerHand').scores() < 22
      if @get('dealerHand').scores() < @get('playerHand').scores()
        @trigger 'player-wins' 
      else
        @trigger 'dealer-wins'
