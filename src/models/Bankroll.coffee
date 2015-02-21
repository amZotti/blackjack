class window.Bankroll extends Backbone.Model

  initialize: ->
    amount = window.localStorage['amount'] or 1000
    currentBet = window.localStorage['bet'] or 100
    @set 'amount', amount
    @set 'currentBet', currentBet

  incrementAmount: ->
    @set('amount', @get('amount') + @get('currentBet'))

  decrementAmount: ->
    @set('amount', @get('amount') - @get('currentBet'))

  changeBet: (bet) ->
    @set('currentBet', bet)
