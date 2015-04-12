class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<img src="img/cards/<%= rankName %>-<%= suitName %>.png" height="139px"/>'

  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    console.log(@$el.html())
    @$el.html('<img src="img/card-back.png" height="139px"/>') unless @model.get 'revealed'

