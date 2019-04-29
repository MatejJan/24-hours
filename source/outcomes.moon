export class Outcomes
  new: =>

  start: =>
    --# Produce and consume worked resources.
    for resourceId, change in pairs TurnStates.Allocation.changes
      Resources[resourceId].quantity += change

    --# See which new resources we've discovered.
    @newResources = {}

    for resourceId, resource in pairs Resources
      continue unless resource.consumption and not resource.introduced and resource.available

      requiredResourcesAvailable = true

      for requiredResourceId, cost in pairs resource.consumption
        unless Resources[requiredResourceId]
          printh "Missing "..requiredResourceId

        unless Resources[requiredResourceId].quantity > 0
          requiredResourcesAvailable = false
          break

      continue unless requiredResourcesAvailable

      add @newResources, resource

    --# Display accumulated resources.
    @displayedResource = [resource for resource in *gameState.introducedResources when resource.quantity > 0]

    @displayedNewResource = nil

  update: =>
    --# Wait for any button press.
    if btnp() > 0
      if #@newResources > 0
        --# Introduce new resources.
        @displayedNewResource = @newResources[1]
        del @newResources, @displayedNewResource

        @displayedNewResource\introduce()

      else
        --# We've shown all the new resources. End turn.
        startTurnState TurnStates.EndTurn

  draw: =>
    color 7

    if @displayedNewResource
      print "-", 58, 62
      print "-", 61, 62
      print ">", 62, 62

      @displayedNewResource\draw 70, 61, 7

      count = 0
      count += 1 for resourceId, cost in pairs @displayedNewResource.consumption
      index = 0

      local previousWidth

      for resourceId, cost in pairs @displayedNewResource.consumption
        top = 61 - (count - 1) * 10 + index * 20
        requiredResource = Resources[resourceId]
        requiredResource\draw 53, top, 7, 0, nil, true

        if index > 0
          print "+", 51 - previousWidth / 2, 62

        previousWidth = #requiredResource.name * 4

        index += 1

    else
      color 7

      top = 0
      left = 9

      for index, resource in pairs @displayedResource
        quantityLeft = left - 4
        quantityLeft -= 4 if resource.quantity > 9

        print resource.quantity, quantityLeft, top + 1

        maxLength = if index + 16 < #@displayedResource then 11 else nil
        resource\draw left, top, 7, nil, maxLength

        top += 8

        if top > 120
          top = 0
          left += 64
