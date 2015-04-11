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
        console.log('we tied')
      else
        console.log('player won with BJ')

  stand: ->
    @revealDealerHand()
    if @get('dealerHand').bestScore() == 21
      console.log 'Dealer BJ'
    else
      while (@get('dealerHand').bestScore() < 17)
        @get('dealerHand').hit()
      @compareScores()

  revealDealerHand: ->
    @get('dealerHand').at(0).flip()

  compareScores: ->
    if @get('dealerHand').bestScore() > @get('playerHand').bestScore()
      console.log('deal wins from score')
    else if @get('dealerHand').bestScore() < @get('playerHand').bestScore()
      console.log('player wins from score')
    else
      console.log('push from score (tie)')



