class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="game-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('game').get('playerHand').hit()
    'click .stand-button': -> @model.get('game').get('playerHand').stand()

  initialize: ->
    @render()

  render: ->
    @$el.html @template()
    @$('.game-container').html new GameView(model: @model.get 'game').el

