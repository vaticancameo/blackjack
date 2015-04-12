class window.GameView extends Backbone.View
  template: _.template '
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '
# events:
  initialize: ->
    @render()
    @model.get('playerHand').on 'add', => @model.get('playerHand').checkScore()
    @model.get('dealerHand').on 'add', => @model.get('dealerHand').checkScore()
    @model.get('playerHand').on 'lose', => @dealerWon()
    #@model.get('playerHand').on 'win', => @playerWon()
    @model.get('dealerHand').on 'lose', => @playerWon()
    @model.get('dealerHand').on 'win', => @dealerWon()
    @model.on 'dealerWin', => @dealerWon()
    @model.on 'playerWin', => @playerWon()
    @model.on 'gameTie', => @tieGame()




  playerWon: ->
    $('.player-hand-container').toggleClass('winner')
    $('.dealer-hand-container').toggleClass('busted')

  dealerWon: ->
    $('.player-hand-container').toggleClass('busted')
    $('.dealer-hand-container').toggleClass('winner')

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  tieGame: ->
    $('.player-hand-container').toggleClass('winner')
    $('.dealer-hand-container').toggleClass('winner')
