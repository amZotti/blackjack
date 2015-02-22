class window.AppView extends Backbone.View
  template: _.template '
    <div id="dealer-display"></div>
    <div id="button-display">
      <button class="hit-button">Hit</button>
      <button class="stand-button">Stand</button>
      <button class="doubledown-button">DoubleDown</button>
      <button class="split-button">Split</button>
    </div>

    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <div class="bet-container"></div>

  '
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
    @playersHand = @model.get 'playerHand'
    @dealersHand = @model.get 'dealerHand'
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('#dealer-display').html new DealerView(collection: @model.get 'dealerHand').el
    @$('.bet-container').html new BankrollView(model: @model.get 'bankroll').el

  renderSplit: ->
    @trigger 'split'
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.bet-container').html new BankrollView(model: @model.get 'bankroll').el
