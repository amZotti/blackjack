class window.DealerView extends Backbone.View

  template: _.template '
    <h1><%= message %></h1>
    <button class="next-round-button">Next Round</button>
  '

  initialize: ->
    @dealersHand = @collection
    @dealersHand.on 'win', @win, @
    @dealersHand.on 'lose', @lose, @

  win: ->
    template = @template message: 'Gameover! Player wins!'
    @render template

  lose: ->
    template = @template message: 'Gameover! Dealer wins!'
    @render template

  render: (template) ->
    $('#button-display').remove()
    @$el.children().detach()
    @$el.html template
