class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    card = @deck.pop()
    @add card
    card
  ,

  stand: ->
  ,  

  play: ->
    @.at(0).flip()
    while @scores()[0] < 18
      @hit()


  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    [@minScore(), @minScore() + 10 * @hasAce()]
  ,

  isOver21: (score) -> score > 21
  ,

  is21: (score) -> score is 21
