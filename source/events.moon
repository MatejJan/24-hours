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

