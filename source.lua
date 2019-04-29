tostring = function(value)
  return value
end
cloneTable = function(source)
  local clone = { }
  for key, value in pairs(source) do
    clone[key] = value
  end
  return clone
end
write = function(text, x, y, width, center, alignBottom)
  local maxCharactersPerLine = flr(width / 4)
  local remainingText = text
  local lines = { }
  while remainingText do
    if #remainingText > maxCharactersPerLine then
      local farthestSpaceIndex = maxCharactersPerLine
      if #remainingText < 2 * maxCharactersPerLine then
        farthestSpaceIndex = #remainingText / 2
      end
      while farthestSpaceIndex > 0 and sub(remainingText, farthestSpaceIndex, farthestSpaceIndex) ~= " " do
        farthestSpaceIndex = farthestSpaceIndex - 1
      end
      if farthestSpaceIndex > 0 then
        local line = sub(remainingText, 0, farthestSpaceIndex)
        remainingText = sub(remainingText, farthestSpaceIndex + 1)
        add(lines, line)
      end
    else
      add(lines, remainingText)
      remainingText = nil
    end
  end
  local top = y
  if alignBottom then
    top = top - #lines * 6
  end
  for _index_0 = 1, #lines do
    local line = lines[_index_0]
    local left = x
    if center then
      local lineWidth = #line * 4
      left = x + flr((width - lineWidth) / 2)
    end
    print(line, left, top)
    top = top + 6
  end
end
do
  local _class_0
  local _base_0 = {
    reset = function(self)
      self.quantity = 0
      self.introduced = false
      self.available = self.initiallyAvailable
    end,
    introduce = function(self)
      add(gameState.introducedResources, self)
      self.introduced = true
      self.available = true
    end,
    draw = function(self, x, y, nameColor, change, maxLength, alignRight, alignCenter)
      if change == nil then
        change = 0
      end
      maxLength = maxLength or #self.name
      if change ~= 0 then
        maxLength = maxLength - 2
      end
      if abs(change) > 9 then
        maxLength = maxLength - 1
      end
      local name = sub(self.name, 1, maxLength)
      local left = x
      local width = 8 + #name * 4
      if alignRight then
        left = left - width
      end
      if alignCenter then
        left = left - (width / 2)
      end
      spr(self.index, left, y)
      color(nameColor)
      print(name, left + 8, y + 1)
      if change ~= 0 then
        color((function()
          if change > 0 then
            return 11
          else
            return 8
          end
        end)())
        return print(tostring((function()
          if change > 0 then
            return "+"
          else
            return ""
          end
        end)()) .. tostring(change), left + 8 + 4 * #name, y + 1)
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, options)
      for key, value in pairs(options) do
        self[key] = value
      end
      Resources[self.id] = self
      self.name = self.name or self.id
      if self.initiallyAvailable == nil then
        self.initiallyAvailable = self.consumption ~= nil
      end
      return self:reset()
    end,
    __base = _base_0,
    __name = "Resource"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Resource = _class_0
end
Resources = { }
Resource({
  index = 0,
  id = 'sleep',
  hourCost = 3
})
Resource({
  index = 1,
  id = 'body',
  hourCost = 2,
  consumption = {
    sleep = 1
  }
})
Resource({
  index = 2,
  id = 'mind',
  hourCost = 2,
  consumption = {
    sleep = 1
  }
})
Resource({
  index = 3,
  id = 'work',
  hourCost = 2,
  initiallyAvailable = false,
  consumption = {
    sleep = 1
  }
})
Resource({
  index = 4,
  id = 'people',
  hourCost = 1
})
Resource({
  index = 5,
  id = 'emotions',
  hourCost = 1
})
Resource({
  index = 6,
  id = 'travel',
  hourCost = 3
})
Resource({
  index = 7,
  id = 'school',
  hourCost = 2
})
Resource({
  index = 8,
  id = 'computer',
  hourCost = 1
})
Resource({
  index = 9,
  id = 'exercise',
  hourCost = 2,
  consumption = {
    body = 1
  }
})
Resource({
  index = 10,
  id = 'sport',
  hourCost = 1,
  consumption = {
    exercise = 1,
    play = 1
  }
})
Resource({
  index = 11,
  id = 'athlete',
  hourCost = 1,
  consumption = {
    sport = 1,
    work = 1
  }
})
Resource({
  index = 12,
  id = 'play',
  hourCost = 1,
  consumption = {
    friends = 1,
    mind = 1
  }
})
Resource({
  index = 13,
  id = 'videoGames',
  name = 'video games',
  hourCost = 1,
  consumption = {
    computer = 1,
    play = 1
  }
})
Resource({
  index = 14,
  id = 'esports',
  hourCost = 1,
  consumption = {
    videoGames = 1,
    work = 1
  }
})
Resource({
  index = 15,
  id = 'friends',
  hourCost = 1,
  consumption = {
    people = 1
  }
})
Resource({
  index = 16,
  id = 'love',
  hourCost = 1,
  consumption = {
    friends = 1,
    emotions = 1
  }
})
Resource({
  index = 17,
  id = 'marriage',
  hourCost = 1,
  initiallyAvailable = false,
  consumption = {
    love = 1,
    work = 1
  }
})
Resource({
  index = 18,
  id = 'kids',
  hourCost = 3,
  initiallyAvailable = false,
  consumption = {
    love = 1,
    people = 1
  }
})
Resource({
  index = 19,
  id = 'astronaut',
  hourCost = 10,
  consumption = {
    travel = 1,
    science = 5
  }
})
Resource({
  index = 20,
  id = 'driver',
  hourCost = 1,
  consumption = {
    travel = 1,
    practice = 1
  }
})
Resource({
  index = 21,
  id = 'theory',
  hourCost = 1,
  consumption = {
    mind = 1,
    school = 1
  }
})
Resource({
  index = 22,
  id = 'science',
  hourCost = 1,
  consumption = {
    theory = 1,
    work = 1
  }
})
Resource({
  index = 23,
  id = 'programing',
  hourCost = 1,
  consumption = {
    computer = 1,
    work = 1
  }
})
Resource({
  index = 24,
  id = 'practice',
  hourCost = 1,
  consumption = {
    school = 1,
    body = 1
  }
})
Resource({
  index = 25,
  id = 'service',
  hourCost = 1,
  consumption = {
    practice = 1,
    work = 1
  }
})
Resource({
  index = 26,
  id = 'doctor',
  hourCost = 1,
  consumption = {
    theory = 1,
    service = 1
  }
})
Resource({
  index = 27,
  id = 'business',
  hourCost = 1,
  consumption = {
    school = 1,
    work = 1
  }
})
Resource({
  index = 28,
  id = 'startup',
  hourCost = 1,
  consumption = {
    business = 1,
    computer = 1
  }
})
Resource({
  index = 29,
  id = 'art',
  hourCost = 1,
  consumption = {
    emotions = 1,
    work = 1
  }
})
Resource({
  index = 30,
  id = 'dance',
  hourCost = 1,
  consumption = {
    emotions = 1,
    exercise = 1
  }
})
Resource({
  index = 31,
  id = 'acting',
  hourCost = 1,
  consumption = {
    art = 1,
    body = 1
  }
})
Resource({
  index = 32,
  id = 'music',
  hourCost = 1,
  consumption = {
    emotions = 1,
    play = 1
  }
})
Resource({
  index = 33,
  id = 'band',
  hourCost = 1,
  consumption = {
    music = 1,
    friends = 1
  }
})
Resource({
  index = 34,
  id = 'graphicDesign',
  name = 'graphic design',
  hourCost = 1,
  consumption = {
    art = 1,
    computer = 1
  }
})
Resource({
  index = 35,
  id = 'therapy',
  hourCost = 1,
  consumption = {
    emotions = 1,
    theory = 1
  }
})
Resource({
  index = 36,
  id = 'politics',
  hourCost = 1,
  consumption = {
    people = 1,
    theory = 1
  }
})
Resource({
  index = 37,
  id = 'socialMedia',
  name = 'social media',
  hourCost = 1,
  consumption = {
    people = 1,
    computer = 1
  }
})
Resource({
  index = 38,
  id = 'influencer',
  hourCost = 1,
  consumption = {
    socialMedia = 1,
    work = 1
  }
})
do
  local _class_0
  local _base_0 = { }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, options)
      for key, value in pairs(options) do
        self[key] = value
      end
      return add(Events, self)
    end,
    __base = _base_0,
    __name = "Event"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Event = _class_0
end
Events = { }
Event({
  description = 'you are born. all you can do is sleep.',
  condition = function()
    return gameState.year == 0
  end,
  provide = function()
    return {
      Resources.sleep
    }
  end
})
Event({
  description = 'trade time to develop your potential.',
  condition = function()
    return gameState.year == 1
  end
})
Event({
  description = 'you have a loving family.',
  condition = function()
    return gameState.year == 2 and rnd(2) < 1
  end,
  provide = function()
    return {
      Resources.people
    }
  end
})
Event({
  description = 'you get a sibling.',
  condition = function()
    if Resources.people.introduced then
      return 
    end
    return gameState.year > 2 and gameState.year < 6 and rnd(5) < 1
  end,
  provide = function()
    return {
      Resources.people
    }
  end
})
Event({
  description = 'you discover you have emotions.',
  condition = function()
    return gameState.year == 4
  end,
  provide = function()
    return {
      Resources.emotions
    }
  end
})
Event({
  description = 'you start going to school.',
  condition = function()
    return gameState.year == 6
  end,
  provide = function()
    return {
      Resources.school
    }
  end
})
Event({
  description = 'you meet your classmates.',
  condition = function()
    if Resources.people.introduced then
      return 
    end
    return gameState.year == 6
  end,
  provide = function()
    return {
      Resources.people
    }
  end
})
Event({
  description = 'you are old enough to work.',
  condition = function()
    return gameState.year == 13
  end,
  provide = function()
    return {
      Resources.work
    }
  end
})
Event({
  description = 'your parents buy you a computer.',
  condition = function()
    if Resources.computer.introduced then
      return 
    end
    return gameState.year > rnd(30)
  end,
  provide = function()
    return {
      Resources.computer
    }
  end
})
Event({
  description = 'you buy yourself a computer.',
  condition = function()
    if Resources.computer.introduced then
      return 
    end
    return gameState.year - 10 > rnd(10)
  end,
  provide = function()
    return {
      Resources.computer
    }
  end
})
Event({
  description = 'you get a passport.',
  condition = function()
    if Resources.travel.introduced then
      return 
    end
    return gameState.year > rnd(20)
  end,
  provide = function()
    return {
      Resources.travel
    }
  end
})
Event({
  description = 'you become of age.',
  condition = function()
    return gameState.year == 18
  end,
  enable = function()
    return {
      Resources.marriage,
      Resources.kids
    }
  end
})
do
  local _class_0
  local _base_0 = {
    start = function(self) end,
    update = function(self)
      if btnp() > 0 then
        return startTurnState(TurnStates.Story)
      end
    end,
    draw = function(self)
      return print("year " .. tostring(gameState.year), 52, 62)
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self) end,
    __base = _base_0,
    __name = "StartTurn"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  StartTurn = _class_0
end
do
  local _class_0
  local _base_0 = {
    reset = function(self) end,
    start = function(self)
      self.availableResources = cloneTable(gameState.introducedResources)
      self.hours = {
        sleep = 24
      }
      self:updateChanges()
      self.selectedIndex = 1
    end,
    update = function(self)
      if self.selectedIndex > 0 then
        local selectedResource = self.availableResources[self.selectedIndex]
        local oldHours = cloneTable(self.hours)
        if btnp(0) and self.hours[selectedResource.id] and self.hours[selectedResource.id] > 0 then
          self.hours[selectedResource.id] = self.hours[selectedResource.id] - 1
          self.hours.sleep = self.hours.sleep + 1
          self:updateChanges()
        end
        if btnp(1) and self.hours.sleep > 0 then
          self.hours[selectedResource.id] = (self.hours[selectedResource.id] or 0) + 1
          self.hours.sleep = self.hours.sleep - 1
          self:updateChanges()
        end
        if not (self.validAllocation) then
          self.hours = oldHours
          self:updateChanges()
        end
      end
      local topIndex
      if self.validAllocation then
        topIndex = 0
      else
        topIndex = 1
      end
      if btnp(2) then
        self.selectedIndex = self.selectedIndex - 1
        if self.selectedIndex < topIndex then
          self.selectedIndex = #self.availableResources
        end
      end
      if btnp(3) then
        self.selectedIndex = self.selectedIndex + 1
        if self.selectedIndex > #self.availableResources then
          self.selectedIndex = topIndex
        end
      end
      if (btnp(4) or btnp(5)) and self.selectedIndex == 0 then
        return startTurnState(TurnStates.Outcomes)
      end
    end,
    updateChanges = function(self)
      self.changes = { }
      for resourceId, hours in pairs(self.hours) do
        local resource = Resources[resourceId]
        local production = flr(hours / resource.hourCost)
        self.changes[resourceId] = (self.changes[resourceId] or 0) + production
        if resource.consumption then
          for requiredResourceId, cost in pairs(resource.consumption) do
            self.changes[requiredResourceId] = (self.changes[requiredResourceId] or 0) - production * cost
          end
        end
      end
      for resourceId, change in pairs(self.changes) do
        if change > 0 then
          self.changes[resourceId] = flr(change)
        else
          self.changes[resourceId] = ceil(change)
        end
      end
      self.validAllocation = true
      for resourceId, resource in pairs(Resources) do
        if resource.quantity + (self.changes[resource.id] or 0) < 0 then
          self.validAllocation = false
        end
      end
    end,
    draw = function(self)
      local offset
      if self.selectedIndex > 0 then
        offset = self.selectedIndex
      else
        offset = #self.availableResources + 1
      end
      offset = max(7, min(#self.availableResources - 5, offset))
      local resourcesTop = 57 - offset * 8
      local resourcesLeft = 9
      local iconLeft = resourcesLeft
      local barLeft = iconLeft + 8
      for index, resource in pairs(self.availableResources) do
        local top = resourcesTop + 8 * (index - 1)
        if index == 1 then
          top = 1
        end
        if index == 2 then
          clip(0, 8, 128, 128)
        end
        if index == self.selectedIndex then
          color(1)
          rectfill(0, top - 1, 128, top + 7)
        end
        local invalid = resource.quantity + (self.changes[resource.id] or 0) < 0
        color((function()
          if invalid then
            return 8
          else
            return 7
          end
        end)())
        local quantity = min(99, flr(resource.quantity))
        if quantity > 0 or invalid then
          local quantityLeft = iconLeft - 4
          if quantity > 9 then
            quantityLeft = quantityLeft - 4
          end
          print(quantity, quantityLeft, top + 1)
        end
        spr(resource.index, iconLeft, top)
        local hours = self.hours[resource.id] or 0
        local barRight = barLeft + hours * 3
        color((function()
          if self.selectedIndex == index then
            return 10
          else
            return 7
          end
        end)())
        rectfill(barLeft, top + 1, barRight, top + 5)
        color(7)
        if hours > 0 then
          print(hours .. "h", barRight + 2, top + 1)
        end
        local change = self.changes[resource.id] or 0
        if change ~= 0 then
          local changeLeft = barRight + 2
          if hours > 0 then
            changeLeft = changeLeft + 8
          end
          if hours > 9 then
            changeLeft = changeLeft + 4
          end
          color((function()
            if change > 0 then
              return 11
            else
              return 8
            end
          end)())
          print(tostring((function()
            if change > 0 then
              return "+"
            else
              return ""
            end
          end)()) .. tostring(change), changeLeft, top + 1)
        end
      end
      clip()
      if self.validAllocation then
        local confirmTop = resourcesTop + 2 + 8 * #self.availableResources
        if self.selectedIndex == 0 then
          color(1)
          rectfill(0, confirmTop - 2, 128, confirmTop + 6)
        end
        color((function()
          if self.selectedIndex == 0 then
            return 10
          else
            return 7
          end
        end)())
        print("confirm", resourcesLeft, confirmTop)
      end
      if self.selectedIndex > 0 then
        local infoTop = 105
        color(0)
        rectfill(0, infoTop, 128, 128)
        color(7)
        line(0, infoTop, 128, infoTop)
        local selectedResource = self.availableResources[self.selectedIndex]
        local change = self.changes[selectedResource.id] or 0
        local invalid = selectedResource.quantity + change < 0
        local nameLeft = 1
        local nameTop = infoTop + 4
        selectedResource:draw(nameLeft, nameTop, 7, 0)
        local quantityLeft = nameLeft + 8
        local quantityTop = nameTop + 8
        color(7)
        print(selectedResource.quantity, quantityLeft, quantityTop)
        if change ~= 0 then
          local changeLeft = quantityLeft + 4
          if selectedResource.quantity > 9 then
            changeLeft = changeLeft + 4
          end
          local changeTop = quantityTop
          color((function()
            if change > 0 then
              return 11
            else
              return 8
            end
          end)())
          print(tostring((function()
            if change > 0 then
              return "+"
            else
              return ""
            end
          end)()) .. tostring(change), changeLeft, changeTop)
        end
        if selectedResource.consumption then
          local requiredResourceLeft = 72
          local requiredResourceTop = nameTop
          for requiredResourceId, cost in pairs(selectedResource.consumption) do
            local time = self.hours[requiredResourceId] or 0
            local consumption = -time * cost
            local requiredResource = Resources[requiredResourceId]
            requiredResource:draw(requiredResourceLeft, requiredResourceTop, 8, consumption, 12)
            requiredResourceTop = requiredResourceTop + 8
          end
        end
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      return self:reset()
    end,
    __base = _base_0,
    __name = "Allocation"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Allocation = _class_0
end
do
  local _class_0
  local _base_0 = {
    start = function(self)
      for resourceId, change in pairs(TurnStates.Allocation.changes) do
        Resources[resourceId].quantity = Resources[resourceId].quantity + change
      end
      self.newResources = { }
      for resourceId, resource in pairs(Resources) do
        local _continue_0 = false
        repeat
          if not (resource.consumption and not resource.introduced and resource.available) then
            _continue_0 = true
            break
          end
          local requiredResourcesAvailable = true
          for requiredResourceId, cost in pairs(resource.consumption) do
            if not (Resources[requiredResourceId]) then
              printh("Missing " .. requiredResourceId)
            end
            if not (Resources[requiredResourceId].quantity > 0) then
              requiredResourcesAvailable = false
              break
            end
          end
          if not (requiredResourcesAvailable) then
            _continue_0 = true
            break
          end
          add(self.newResources, resource)
          _continue_0 = true
        until true
        if not _continue_0 then
          break
        end
      end
      do
        local _accum_0 = { }
        local _len_0 = 1
        local _list_0 = gameState.introducedResources
        for _index_0 = 1, #_list_0 do
          local resource = _list_0[_index_0]
          if resource.quantity > 0 then
            _accum_0[_len_0] = resource
            _len_0 = _len_0 + 1
          end
        end
        self.displayedResource = _accum_0
      end
      self.displayedNewResource = nil
    end,
    update = function(self)
      if btnp() > 0 then
        if #self.newResources > 0 then
          self.displayedNewResource = self.newResources[1]
          del(self.newResources, self.displayedNewResource)
          return self.displayedNewResource:introduce()
        else
          return startTurnState(TurnStates.EndTurn)
        end
      end
    end,
    draw = function(self)
      color(7)
      if self.displayedNewResource then
        print("-", 58, 62)
        print("-", 61, 62)
        print(">", 62, 62)
        self.displayedNewResource:draw(70, 61, 7)
        local count = 0
        for resourceId, cost in pairs(self.displayedNewResource.consumption) do
          count = count + 1
        end
        local index = 0
        local previousWidth
        for resourceId, cost in pairs(self.displayedNewResource.consumption) do
          local top = 61 - (count - 1) * 10 + index * 20
          local requiredResource = Resources[resourceId]
          requiredResource:draw(53, top, 7, 0, nil, true)
          if index > 0 then
            print("+", 51 - previousWidth / 2, 62)
          end
          previousWidth = #requiredResource.name * 4
          index = index + 1
        end
      else
        color(7)
        local top = 0
        local left = 9
        for index, resource in pairs(self.displayedResource) do
          local quantityLeft = left - 4
          if resource.quantity > 9 then
            quantityLeft = quantityLeft - 4
          end
          print(resource.quantity, quantityLeft, top + 1)
          local maxLength
          if index + 16 < #self.displayedResource then
            maxLength = 11
          else
            maxLength = nil
          end
          resource:draw(left, top, 7, nil, maxLength)
          top = top + 8
          if top > 120 then
            top = 0
            left = left + 64
          end
        end
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self) end,
    __base = _base_0,
    __name = "Outcomes"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Outcomes = _class_0
end
do
  local _class_0
  local _base_0 = {
    start = function(self)
      self.events = { }
      for _index_0 = 1, #Events do
        local event = Events[_index_0]
        if event.condition() then
          if event.provide then
            local resources = event.provide()
            for _index_1 = 1, #resources do
              local resource = resources[_index_1]
              resource:introduce()
            end
          end
          if event.enable then
            local resources = event.enable()
            for _index_1 = 1, #resources do
              local resource = resources[_index_1]
              resource.available = true
            end
          end
          add(self.events, event)
        end
      end
    end,
    update = function(self)
      if #self.events == 0 then
        startTurnState(TurnStates.Allocation)
        return 
      end
      if btnp() > 0 then
        return del(self.events, self.events[1])
      end
    end,
    draw = function(self)
      local event = self.events[1]
      if not (event) then
        return 
      end
      write(event.description, 0, 62, 128, true, event.provide)
      if event.provide then
        local top = 70
        local _list_0 = event.provide()
        for _index_0 = 1, #_list_0 do
          local resource = _list_0[_index_0]
          resource:draw(64, top, 7, 0, nil, false, true)
          top = top + 10
        end
      end
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self) end,
    __base = _base_0,
    __name = "Story"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Story = _class_0
end
do
  local _class_0
  local _base_0 = {
    start = function(self)
      gameState.year = gameState.year + 1
    end,
    update = function(self)
      return startTurnState(TurnStates.StartTurn)
    end,
    draw = function(self) end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self) end,
    __base = _base_0,
    __name = "EndTurn"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  EndTurn = _class_0
end
initialize = function()
  gameState.year = 0
  gameState.introducedResources = { }
  for resourceId, resource in pairs(Resources) do
    resource:reset()
  end
  TurnStates.Allocation:reset()
  return startTurnState(TurnStates.StartTurn)
end
TurnStates = {
  StartTurn = StartTurn(),
  Story = Story(),
  Allocation = Allocation(),
  Outcomes = Outcomes(),
  EndTurn = EndTurn()
}
gameState = { }
startTurnState = function(turnState)
  gameState.turnState = turnState
  return turnState:start()
end
_init = function()
  return initialize()
end
_update = function()
  return gameState.turnState:update()
end
_draw = function()
  cls()
  return gameState.turnState:draw()
end
