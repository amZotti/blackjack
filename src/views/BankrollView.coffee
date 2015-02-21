class window.BankrollView extends Backbone.View

  template: _.template '
    <div> Current Bet:
      <input type="text" value=<%= currentBet %>></input>
      <button class="bet-button">Bet</button>
    </div>

    <div> Cash money: <%= amount %></div>
  '

  initialize: ->
    @render()

  render: ->
    @$el.html @template @model.attributes


