class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->
   
  hit: ->
    @add(@deck.pop()).last()
    if @scores()[1] is 21 or @scores()[0] is 21
      alert 'blackJack!'
    if @scores()[1] is 1 and @scores()[0] >21
      alert 'busted!'
    if @scores()[0] > 21 and @scores()[1] > 21
      alert 'busted!'

  stand: -> @trigger('turnOver', @)

  bust: ->
    console.log "score is #{@scores()}"

    status = if @scores()[0] > 18 then true else false
    console.log status

  gameOver: ->
    @trigger('gameSet', @)

    #finish the turn to the dealer. no more cards

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score, 1]
