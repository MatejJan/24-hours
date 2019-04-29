export class Allocation
  new: =>
    @reset()

  reset: =>


  start: =>
    --# Available resources are the ones that have been introduced.
    @availableResources = cloneTable gameState.introducedResources

    --# Start with 24h sleeping.
    @hours = sleep: 24

    --# Calculate initial changes.
    @updateChanges()

    --# Reset GUI.
    @selectedIndex = 1

  update: =>
    if @selectedIndex > 0
      selectedResource = @availableResources[@selectedIndex]

      oldHours = cloneTable @hours

      if btnp(0) and @hours[selectedResource.id] and @hours[selectedResource.id] > 0
        --# Left was pressed. Decrease hours if any are assigned.
        @hours[selectedResource.id] -= 1
        @hours.sleep += 1
        @updateChanges()

      if btnp(1) and @hours.sleep > 0
        --# Right was pressed. Increase hours if you can take them away from sleep.
        @hours[selectedResource.id] = (@hours[selectedResource.id] or 0) + 1
        @hours.sleep -= 1
        @updateChanges()

      --# Revert changes if an invalid allocation occurs.
      unless @validAllocation
        @hours = oldHours
        @updateChanges()

    topIndex = if @validAllocation then 0 else 1

    if btnp 2
      --# Up was pressed.
      @selectedIndex -= 1
      @selectedIndex = #@availableResources if @selectedIndex < topIndex

    if btnp 3
      --# Down was pressed.
      @selectedIndex += 1
      @selectedIndex = topIndex if @selectedIndex > #@availableResources

    if (btnp(4) or btnp(5)) and @selectedIndex == 0
      --# Player has confirmed their selection, move to next turn state.
      startTurnState TurnStates.Outcomes

  updateChanges: =>
    @changes = {}

    --# Produce and consume worked resources.
    for resourceId, hours in pairs @hours
      resource = Resources[resourceId]

      --# Increase change by production.
      production = flr hours / resource.hourCost
      @changes[resourceId] = (@changes[resourceId] or 0) + production

      --# Decrease consumed resources' change.
      if resource.consumption
        for requiredResourceId, cost in pairs resource.consumption
          @changes[requiredResourceId] = (@changes[requiredResourceId] or 0) - production * cost

    --# Round the changes.
    for resourceId, change in pairs @changes
      @changes[resourceId] = if change > 0 then flr change else ceil change

    --# See if this is a valid allocation.
    @validAllocation = true

    for resourceId, resource in pairs Resources
      if resource.quantity + (@changes[resource.id] or 0) < 0
        @validAllocation = false

  draw: =>
    offset = if @selectedIndex > 0 then @selectedIndex else #@availableResources + 1
    offset = max 7, min #@availableResources - 5, offset
    resourcesTop = 57 - offset * 8
    resourcesLeft = 9

    iconLeft = resourcesLeft
    barLeft = iconLeft + 8

    for index, resource in pairs @availableResources
      top = resourcesTop + 8 * (index - 1)
      top = 1 if index == 1

      clip 0, 8, 128, 128 if index == 2

      --# Draw selected bar
      if index == @selectedIndex
        color 1
        rectfill 0, top - 1, 128, top + 7

      --# Write quantity
      invalid = resource.quantity + (@changes[resource.id] or 0) < 0
      color if invalid then 8 else 7
      quantity = min 99, flr resource.quantity

      if quantity > 0 or invalid
        quantityLeft = iconLeft - 4
        quantityLeft -= 4 if quantity > 9

        print quantity, quantityLeft, top + 1

      --# Draw icon.
      spr resource.index, iconLeft, top

      --# Draw the hours bar.
      hours = @hours[resource.id] or 0
      barRight = barLeft + hours * 3

      color if @selectedIndex == index then 10 else 7
      rectfill barLeft, top + 1, barRight, top + 5

      color 7
      print hours.."h", barRight + 2, top + 1 if hours > 0

      change = @changes[resource.id] or 0

      if change != 0
        changeLeft = barRight + 2
        changeLeft += 8 if hours > 0
        changeLeft += 4 if hours > 9

        color if change > 0 then 11 else 8
        print "#{if change > 0 then "+" else ""}#{change}", changeLeft, top + 1

    clip()

    if @validAllocation
      confirmTop = resourcesTop + 2 + 8 * #@availableResources

      --# Draw selected bar
      if @selectedIndex == 0
        color 1
        rectfill 0, confirmTop - 2, 128, confirmTop + 6

      color if @selectedIndex == 0 then 10 else 7
      print "confirm", resourcesLeft, confirmTop

    --# Draw information box.

    if @selectedIndex > 0
      infoTop = 105

      color 0
      rectfill 0, infoTop, 128, 128

      color 7
      line 0, infoTop, 128, infoTop

      selectedResource = @availableResources[@selectedIndex]

      --# Write resource info.
      change = @changes[selectedResource.id] or 0
      invalid = selectedResource.quantity + change < 0

      nameLeft = 1
      nameTop = infoTop + 4

      selectedResource\draw nameLeft, nameTop, 7, 0

      quantityLeft = nameLeft + 8
      quantityTop = nameTop + 8

      color 7
      print selectedResource.quantity, quantityLeft, quantityTop

      if change != 0
        changeLeft = quantityLeft + 4
        changeLeft += 4 if selectedResource.quantity > 9
        changeTop = quantityTop

        color if change > 0 then 11 else 8
        print "#{if change > 0 then "+" else ""}#{change}", changeLeft, changeTop

      if selectedResource.consumption
        requiredResourceLeft = 72
        requiredResourceTop = nameTop

        for requiredResourceId, cost in pairs selectedResource.consumption
          time = @hours[requiredResourceId] or 0
          consumption = -time * cost

          requiredResource = Resources[requiredResourceId]
          requiredResource\draw requiredResourceLeft, requiredResourceTop, 8, consumption, 12

          requiredResourceTop += 8
