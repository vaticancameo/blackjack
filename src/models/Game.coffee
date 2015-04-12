class window.Game extends Backbone.Model
  initialize : ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @checkForBlackjack()

  checkForBlackjack : ->
    if @get('playerHand').bestScore() == 21
      @revealDealerHand()
      if @get('dealerHand').bestScore() == 21
        @trigger('gameTie', this)
      else
        @trigger('playerWin', this)

  stand: ->
    @revealDealerHand()
    if @get('dealerHand').bestScore() == 21
      @trigger('dealerWin', this)
    else
      while (@get('dealerHand').bestScore() < 17)
        @get('dealerHand').hit()
    if @get('dealerHand').bestScore() < 22 and @get('playerHand').bestScore() < 22
      @compareScores()

  revealDealerHand: ->
    @get('dealerHand').at(0).flip()

  compareScores: ->
    if @get('dealerHand').bestScore() > @get('playerHand').bestScore()
      @trigger('dealerWin', this)
    else if @get('dealerHand').bestScore() < @get('playerHand').bestScore()
      @trigger('playerWin', this)
    else
      @trigger('gameTie', this);



