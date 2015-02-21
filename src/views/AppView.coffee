class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  resultsTemplate: _.template '
    <h1><%= message %></h1>
    <button class="next-round-button">Next Round</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  win: ->
    resultTemplate = @resultsTemplate message: 'Gameover! Player wins!'
    @renderResult resultTemplate

  lose: ->
    resultTemplate = @resultsTemplate message: 'Gameover! Dealer wins!'
    @renderResult resultTemplate

  events:
    'click .hit-button': ->
      @playersHand.hit @dealersHand
      @playersHand.didPlayerWin @dealersHand

    'click .stand-button': ->
      @playersHand.stand @dealersHand
      @playersHand.didPlayerWin @dealersHand

    'click .next-round-button': ->
      window.location.reload()

  initialize: ->
    @dealersHand = @model.get 'dealerHand'
    @playersHand = @model.get 'playerHand'
    @dealersHand.on 'win', @win, @
    @dealersHand.on 'lose', @lose, @
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  renderResult: (resultTemplate) ->
    @$el.children().detach()
    @$el.html resultTemplate
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

