export TurnStates = {
  StartTurn: StartTurn()
  Story: Story()
  Allocation: Allocation()
  Outcomes: Outcomes()
  EndTurn: EndTurn()
}

export gameState = {}

export startTurnState = (turnState) ->
  gameState.turnState = turnState
  turnState\start()

export _init = ->
  initialize()

export _update = ->
  gameState.turnState\update()

export _draw = ->
  cls()
  gameState.turnState\draw()
