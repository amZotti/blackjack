class window.Bankroll extends Backbone.Model

  initialize: ->
    @set 'amount', 1000
    @set 'currentBet', 100

  incrementAmount: ->
    @set('amount', @get('amount') + @get('currentBet'))

  decrementAmount: ->
    @set('amount', @get('amount') - @get('currentBet'))

  changeBet: (bet) ->
    @set('currentBet', bet)
