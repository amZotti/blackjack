class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  canSplit: ->
    @at(0).get('value') is @at(1).get('value')

  doubledown: (dealersHand) ->
    @hit dealersHand
    @stand dealersHand
    @didPlayerWin dealersHand

  hit: ->
    card = @deck.pop()
    @add(card)
    card

  stand: (dealersHand) ->
    while dealersHand.getHandScore() < 18
      dealersHand.hit()
    if dealersHand.getHandScore() < 21
      dealersHand.at(0).flip()
      @settleDraw dealersHand
    dealersHand

  getHandScore: ->
    score = 0
    @each (card) ->
      score += card.get 'value'
    score

  didPlayerWin: (dealersHand) ->
    playerScore = @getHandScore()
    dealerScore = dealersHand.getHandScore()
    if playerScore > 21 or dealerScore is 21
      dealersHand.at(0).flip()
      dealersHand.trigger 'lose'
      false
    else if dealerScore > 21 or playerScore is 21
      dealersHand.at(0).flip()
      dealersHand.trigger 'win'
      true

  settleDraw: (dealersHand) ->
    playerScore = @getHandScore()
    dealerScore = dealersHand.getHandScore()
    if playerScore > dealerScore
      dealersHand.trigger 'win'
      true
    else
      dealersHand.trigger 'lose'
      false

  hasAce: -> @reduce (memo, card) ->
    memo or card.get 'value' is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]


