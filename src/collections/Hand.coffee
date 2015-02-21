class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: () ->
    @add(@deck.pop())

  stand: (dealersHand) ->
    while dealersHand.getHandScore() < 18
      dealersHand.hit()


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
      dealersHand.trigger('lose')
    else if dealerScore > 21 or playerScore is 21
      dealersHand.at(0).flip()
      dealersHand.trigger('win')

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


