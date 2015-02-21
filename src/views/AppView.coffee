class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button>
    <button class="stand-button">Stand</button>
    <button class="doubledown-button">DoubleDown</button>
    <button class="split-button">Split</button>


    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <div class="bet-container"></div>

  '

  resultsTemplate: _.template '
    <h1><%= message %></h1>
    <button class="next-round-button">Next Round</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <div class="bet-container"></div>
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

    'click .doubledown-button': ->
      @playersHand.doubledown @dealersHand

    'click .split-button': ->
     unless @playersHand.canSplit()
       @renderSplit()
     else
       alert 'Cannot split without pairs'


    'click .next-round-button': ->
      window.localStorage.amount = @model.get('bankroll').get('amount')
      window.localStorage.currentBet = @model.get('bankroll').get('currentBet')
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
    @$('.bet-container').html new BankrollView(model: @model.get 'bankroll').el


  renderResult: (resultTemplate) ->
    @$el.children().detach()
    @$el.html resultTemplate
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.bet-container').html new BankrollView(model: @model.get 'bankroll').el

  renderSplit: ->
    console.log @
    @trigger 'split'
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.bet-container').html new BankrollView(model: @model.get 'bankroll').el
