# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    window.bbq = @get('dealerHand')
    dealerHand = @get('dealerHand')
    playerHand = @get('playerHand')
    playerHand.on('flip end', ->
      dealerHand.at(0).flip()
      @determineWinner()
    ),

    
    determineWinner: ->
      dealerScore = @get('dealerHand').score()
      playerScore = @get('playerHand').score()


