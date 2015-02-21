assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null
  dealer = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()
    dealer = deck.dealDealer()

  describe 'hit', ->
    it 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 48
      assert.strictEqual deck.last(), hand.hit()
      assert.strictEqual deck.length, 47

  describe 'stand', ->
    it 'should not add cards to the players hand', ->
      assert.strictEqual hand.models.length, 2
      hand.stand(dealer)
      assert.strictEqual hand.models.length, 2

    it 'should increment the dealers hand score above 17', ->
      dealer.at(0).set('value', 0)
      hand.stand(dealer)
      assert dealer.getHandScore() > 17

  describe 'didPlayerWin', ->
    it 'should return false when players hand is greater than 21', ->
      hand.at(0).set('value', 22)
      assert (hand.didPlayerWin(dealer) is false)

    it 'should return false when the players hand and the dealers hand are both under 21 and the dealers hand is greater', ->
      hand.at(0).set('value', 0)
      hand.at(1).set('value', 0)
      assert (hand.settleDraw(dealer) is false)

    it 'should return false when both player and dealer tie', ->
      hand.at(0).set('value', 10)
      hand.at(1).set('value', 11)
      dealer.at(0).set('value', 10)
      dealer.at(1).set('value', 11)
      assert (hand.didPlayerWin(dealer) is false)

  describe 'double down', ->
    it 'should cause player to draw only a single card', ->
      hand.doubledown(dealer)
      assert(hand.models.length is 3)

