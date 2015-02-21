class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    @render()

  ended: ->
   @collection.trigger 'flip' 

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    score = @collection.scores()[0]
    status = ""
    if @collection.isOver21 score
      @ended()
      status = 'a fine loss!'
    else if @collection.is21 score 
      @collection.is21 score 
      status = 'ah win win win nomatter wot'
    @$('.score').text score + status
