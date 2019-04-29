export class StartTurn
  new: =>

  start: =>

  update: =>
    --# Wait for any button press.
    if btnp() > 0
      startTurnState TurnStates.Story

  draw: =>
    print "year #{gameState.year}", 52, 62
