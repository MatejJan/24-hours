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
