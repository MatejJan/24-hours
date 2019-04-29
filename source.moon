export tostring = (value) -> value

export cloneTable = (source) ->
  clone = {}

  for key, value in pairs source
    clone[key] = value

  clone

export write = (text, x, y, width, center, alignBottom) ->
  maxCharactersPerLine = flr width / 4
  remainingText = text
  lines = {}

  while remainingText
    if #remainingText > maxCharactersPerLine
      --# Perform wrapping. Search from last possible character backwards for a space.
      farthestSpaceIndex = maxCharactersPerLine

      --# Balance last two lines more equally.
      if #remainingText < 2 * maxCharactersPerLine
        farthestSpaceIndex = #remainingText / 2

      while farthestSpaceIndex > 0 and sub(remainingText, farthestSpaceIndex, farthestSpaceIndex) != " "
        farthestSpaceIndex -= 1

      if farthestSpaceIndex > 0
        line = sub remainingText, 0, farthestSpaceIndex
        remainingText = sub remainingText, farthestSpaceIndex + 1
        add lines, line

    else
      add lines, remainingText
      remainingText = nil

  top = y

  if alignBottom
    top -= #lines * 6

  for line in *lines
    left = x

    if center
      lineWidth = #line * 4
      left = x + flr (width - lineWidth) / 2

    print line, left, top
    top += 6
export class Resource
  new: (options) =>
    --# Transfer options to instance.
    @[key] = value for key, value in pairs options

    --# Register global instance.
    Resources[@id] = @

    --# Set defaults.
    @name or= @id

    if @initiallyAvailable == nil
      --# Resources with consumption are available by default.
      @initiallyAvailable = @consumption != nil

    --# Initialize instance variables.
    @reset()

  reset: =>
    @quantity = 0
    @introduced = false
    @available = @initiallyAvailable

  introduce: =>
    add gameState.introducedResources, @
    @introduced = true
    @available = true

  draw: (x, y, nameColor, change=0, maxLength, alignRight, alignCenter) =>
    maxLength or= #@name
    maxLength -= 2 if change != 0
    maxLength -= 1 if abs(change) > 9
    name = sub @name, 1, maxLength

    left = x
    width = 8 + #name * 4

    left -= width if alignRight
    left -= width / 2 if alignCenter

    spr @index, left, y

    color nameColor
    print name, left + 8, y + 1

    if change != 0
      color if change > 0 then 11 else 8
      print "#{if change > 0 then "+" else ""}#{change}", left + 8 + 4 * #name, y + 1
export Resources = {}

--# Activities

Resource
  index: 0
  id: 'sleep'
  hourCost: 3

Resource
  index: 1
  id: 'body'
  hourCost: 2
  consumption:
    sleep: 1

Resource
  index: 2
  id: 'mind'
  hourCost: 2
  consumption:
    sleep: 1

Resource
  index: 3
  id: 'work'
  hourCost: 2
  initiallyAvailable: false
  consumption:
    sleep: 1

--# Environment

Resource
  index: 4
  id: 'people'
  hourCost: 1

Resource
  index: 5
  id: 'emotions'
  hourCost: 1

Resource
  index: 6
  id: 'travel'
  hourCost: 3

Resource
  index: 7
  id: 'school'
  hourCost: 2

Resource
  index: 8
  id: 'computer'
  hourCost: 1

--# Sports

Resource
  index: 9
  id: 'exercise'
  hourCost: 2
  consumption:
    body: 1

Resource
  index: 10
  id: 'sport'
  hourCost: 1
  consumption:
    exercise: 1
    play: 1

Resource
  index: 11
  id: 'athlete'
  hourCost: 1
  consumption:
    sport: 1
    work: 1

--# Games

Resource
  index: 12
  id: 'play'
  hourCost: 1
  consumption:
    friends: 1
    mind: 1

Resource
  index: 13
  id: 'videoGames'
  name: 'video games'
  hourCost: 1
  consumption:
    computer: 1
    play: 1

Resource
  index: 14
  id: 'esports'
  hourCost: 1
  consumption:
    videoGames: 1
    work: 1

--# Relationships

Resource
  index: 15
  id: 'friends'
  hourCost: 1
  consumption:
    people: 1

Resource
  index: 16
  id: 'love'
  hourCost: 1
  consumption:
    friends: 1
    emotions: 1

Resource
  index: 17
  id: 'marriage'
  hourCost: 1
  initiallyAvailable: false
  consumption:
    love: 1
    work: 1

Resource
  index: 18
  id: 'kids'
  hourCost: 3
  initiallyAvailable: false
  consumption:
    love: 1
    people: 1

--# Travel

Resource
  index: 19
  id: 'astronaut'
  hourCost: 10
  consumption:
    travel: 1
    science: 5

Resource
  index: 20
  id: 'driver'
  hourCost: 1
  consumption:
    travel: 1
    practice: 1

--# Mind career

Resource
  index: 21
  id: 'theory'
  hourCost: 1
  consumption:
    mind: 1
    school: 1

Resource
  index: 22
  id: 'science'
  hourCost: 1
  consumption:
    theory: 1
    work: 1

Resource
  index: 23
  id: 'programing'
  hourCost: 1
  consumption:
    computer: 1
    work: 1

--# Body career

Resource
  index: 24
  id: 'practice'
  hourCost: 1
  consumption:
    school: 1
    body: 1

Resource
  index: 25
  id: 'service'
  hourCost: 1
  consumption:
    practice: 1
    work: 1

Resource
  index: 26
  id: 'doctor'
  hourCost: 1
  consumption:
    theory: 1
    service: 1

--# Work career

Resource
  index: 27
  id: 'business'
  hourCost: 1
  consumption:
    school: 1
    work: 1

Resource
  index: 28
  id: 'startup'
  hourCost: 1
  consumption:
    business: 1
    computer: 1

--# Emotion career

Resource
  index: 29
  id: 'art'
  hourCost: 1
  consumption:
    emotions: 1
    work: 1

Resource
  index: 30
  id: 'dance'
  hourCost: 1
  consumption:
    emotions: 1
    exercise: 1

Resource
  index: 31
  id: 'acting'
  hourCost: 1
  consumption:
    art: 1
    body: 1

Resource
  index: 32
  id: 'music'
  hourCost: 1
  consumption:
    emotions: 1
    play: 1

Resource
  index: 33
  id: 'band'
  hourCost: 1
  consumption:
    music: 1
    friends: 1

Resource
  index: 34
  id: 'graphicDesign'
  name: 'graphic design'
  hourCost: 1
  consumption:
    art: 1
    computer: 1

Resource
  index: 35
  id: 'therapy'
  hourCost: 1
  consumption:
    emotions: 1
    theory: 1

--# People career

Resource
  index: 36
  id: 'politics'
  hourCost: 1
  consumption:
    people: 1
    theory: 1

Resource
  index: 37
  id: 'socialMedia'
  name: 'social media'
  hourCost: 1
  consumption:
    people: 1
    computer: 1

Resource
  index: 38
  id: 'influencer'
  hourCost: 1
  consumption:
    socialMedia: 1
    work: 1
export class Event
  new: (options) =>
    --# Transfer options to instance.
    @[key] = value for key, value in pairs options

    --# Register global instance.
    add Events, @
export Events = {}

Event
  description: 'you are born. all you can do is sleep.'
  condition: ->
    gameState.year == 0
  provide: -> {
    Resources.sleep
  }

Event
  description: 'trade time to develop your potential.'
  condition: ->
    gameState.year == 1


Event
  description: 'you have a loving family.'
  condition: ->
    gameState.year == 2 and rnd(2) < 1
  provide: -> {
    Resources.people
  }

Event
  description: 'you get a sibling.'
  condition: ->
    return if Resources.people.introduced
    gameState.year > 2 and gameState.year < 6 and rnd(5) < 1
  provide: -> {
    Resources.people
  }

Event
  description: 'you discover you have emotions.'
  condition: ->
    gameState.year == 4
  provide: -> {
    Resources.emotions
}

Event
  description: 'you start going to school.'
  condition: ->
    gameState.year == 6
  provide: -> {
    Resources.school
}

Event
  description: 'you meet your classmates.'
  condition: ->
    return if Resources.people.introduced
    gameState.year == 6
  provide: -> {
    Resources.people
  }

Event
  description: 'you are old enough to work.'
  condition: ->
    gameState.year == 13
  provide: -> {
    Resources.work
}

Event
  description: 'your parents buy you a computer.'
  condition: ->
    return if Resources.computer.introduced
    gameState.year > rnd 30
  provide: -> {
    Resources.computer
}

Event
  description: 'you buy yourself a computer.'
  condition: ->
    return if Resources.computer.introduced
    gameState.year - 10 > rnd 10
  provide: -> {
    Resources.computer
}

Event
  description: 'you get a passport.'
  condition: ->
    return if Resources.travel.introduced
    gameState.year > rnd 20
  provide: -> {
    Resources.travel
}

Event
  description: 'you become of age.'
  condition: ->
    gameState.year == 18
  enable: -> {
    Resources.marriage
    Resources.kids
  }

--# Events if you skip school (warning, expulsion)

export class StartTurn
  new: =>

  start: =>

  update: =>
    --# Wait for any button press.
    if btnp() > 0
      startTurnState TurnStates.Story

  draw: =>
    print "year #{gameState.year}", 52, 62
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
export class Story
  new: =>

  start: =>
    @events = {}

    for event in *Events
      if event.condition()
        --# Apply event effects.
        if event.provide
          resources = event.provide()
          resource\introduce() for resource in *resources

        if event.enable
          resources = event.enable()
          resource.available = true for resource in *resources

        add @events, event

  update: =>
    --# End turn if we have no more events to show.
    if #@events == 0
      startTurnState TurnStates.Allocation
      return

    --# Wait for any button press.
    if btnp() > 0
      --# Go to next event.
      del @events, @events[1]

  draw: =>
    event = @events[1]
    return unless event

    write event.description, 0, 62, 128, true, event.provide

    if event.provide
      top = 70
      for resource in *event.provide()
        resource\draw 64, top, 7, 0, nil, false, true
        top += 10
export class EndTurn
  new: =>

  start: =>
    gameState.year += 1

  update: =>
    startTurnState TurnStates.StartTurn

  draw: =>
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
