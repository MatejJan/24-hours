export initialize = ->
  --# Reset game state.
  gameState.year = 0
  gameState.introducedResources = {}

  --# Reset all resources.
  resource\reset() for resourceId, resource in pairs Resources

  --# Reset turn states.
  TurnStates.Allocation\reset()

  --# Make sleep available.
  --# Resources.friends\introduce()
  --# Resources.friends.quantity = 5

  --# Resources.mind\introduce()
  --# Resources.mind.quantity = 5

  --# for resourceId, resource in pairs Resources
  --#   if rnd(3) < 1
  --#     resource\introduce()
  --#     resource.quantity = ceil rnd 20

  --# Set start turn state.
  startTurnState TurnStates.StartTurn
