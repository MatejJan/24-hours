export class EndTurn
  new: =>

  start: =>
    gameState.year += 1

  update: =>
    startTurnState TurnStates.StartTurn

  draw: =>
