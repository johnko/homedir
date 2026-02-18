local mousehighlight = {}

mousehighlight.mouseCircle = {}
for index, _ in ipairs({0, 1, 2, 3, 4, 5, 6, 7, 8, 9}) do
  mousehighlight.mouseCircle[index] = nil
end
mousehighlight.mouseCircleTimer = {}
for index, _ in ipairs({0, 1, 2, 3, 4, 5, 6, 7, 8, 9}) do
  mousehighlight.mouseCircleTimer[index] = nil
end

mousehighlight.drawCircle = function(mousepoint, index)
  local radius = index*40
  -- Prepare a big red circle around the mouse pointer
  mousehighlight.mouseCircle[index] = hs.drawing.circle(hs.geometry.rect(mousepoint.x-radius, mousepoint.y-radius, 2*radius, 2*radius))
  mousehighlight.mouseCircle[index]:setStrokeColor({["red"]=1,["blue"]=0,["green"]=0,["alpha"]=1})
  mousehighlight.mouseCircle[index]:setFill(false)
  mousehighlight.mouseCircle[index]:setStrokeWidth(5)
  mousehighlight.mouseCircle[index]:show()
  -- Set a timer to delete the circle after 1 second
  mousehighlight.mouseCircleTimer[index] = hs.timer.doAfter(1, function()
    mousehighlight.mouseCircle[index]:delete()
    mousehighlight.mouseCircle[index] = nil
  end)
end

mousehighlight.mouseHighlight = function()
  -- Delete an existing highlight if it exists
  for index, _ in ipairs({0, 1, 2, 3, 4, 5, 6, 7, 8, 9}) do
    if mousehighlight.mouseCircle[index] then
      mousehighlight.mouseCircle[index]:delete()
      if mousehighlight.mouseCircleTimer[index] then
        mousehighlight.mouseCircleTimer[index]:stop()
      end
    end
  end
  -- Get the current co-ordinates of the mouse pointer
  mousepoint = hs.mouse.absolutePosition()
  for index, _ in ipairs({0, 1, 2, 3, 4, 5, 6, 7, 8, 9}) do
    mousehighlight.drawCircle(mousepoint, index)
  end
end

return mousehighlight
