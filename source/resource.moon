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
