class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <div class="winner-container"></div>  
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
    'click #new-game' : -> location.reload(true)


  
  initialize: ->
    @render()
    @model.on 'all', @winnerAlert, @

  winnerAlert: (event) ->
    switch event
      when 'dealer-wins' then @newGame('Dealer Wins!')
      when 'player-wins' then @newGame('Player Wins!')

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  newGame: (string)->
    $('button').prop('disabled', true )
    alert(string)
    $('button').last().after('<button id = "new-game">New Game</button>')
    

