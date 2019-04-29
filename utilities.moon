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
