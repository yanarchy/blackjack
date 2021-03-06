class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: () ->
    @add(@deck.pop())
    console.log(@.scores()[0])

    if @.scores()[0] > 21
      alert('lose!')

    else if @.scores()[0] == 21
      alert('win')

  call: false

  stand: (playerScore) ->
    if @call == false
      @.models[0].flip()
      @call = true

    if @.scores()[0] < 17
      console.log(@.scores()[0])
      @add(@deck.pop())
      @stand(playerScore)
      #trying to call the stand function again in order
      #for the dealer to play automaticly instead of
      #only plays when we hit the stand botton
    else if @.scores()[0] > 21
      console.log('greater than 21')
      alert('Win')
    else
      console.log('compare score')
      @compareScore(playerScore, @.scores()[0])

#dealer begins to play
#new function that checks dealer's score
  #if dealer's score is less than 17, dealer deals
  #if dealer's score is over 21, dealer loses
  #if dealer's score is less than 21 and higher than
    #player, dealer wins

  # checkScore: (score) ->
  #   if score > 21
  #     return true
  #   else
  #     return false
  #   #check if greater than 21 or not.
  #     #if greater than 21, false
  #     #if less than 21, true

  compareScore: (playerScore, dealerScore) ->
    if playerScore > dealerScore
      console.log('player>dealer')
      alert("win!")
    else if playerScore == dealerScore
      console.log('tie')
      alert('tie!')
    else
      alert ('lose!')


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
