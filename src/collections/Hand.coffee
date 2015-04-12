class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  checkFor21: ->
    if _.contains(@scores(), 21) then @trigger('win', this)

  isBusted: ->
    if @scores()[0] > 21 then @trigger('lose', this)

  checkScore: ->
    @checkFor21()
    @isBusted()


  bestScore: ->
    return if (@scores()[1] > 21) then @scores()[0] else @scores()[1]

#@trigger('lose', this)
#console.log('busted!') for score in @scores when score > 21
