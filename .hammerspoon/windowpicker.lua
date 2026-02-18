-- Window shortcuts

-- Original Source: https://github.com/evantravers/hammerspoon-config/blob/be5c9284b02f2e509d53385a73e778ba7505532b/movewindows.lua

local windowpicker = {}

windowpicker.logger = hs.logger.new("windowpicker")

windowpicker.target_display = function(display_int)
  -- detect the current number of monitors
  windowpicker.displays = hs.screen.allScreens()
  if windowpicker.displays[display_int] ~= nil then
    return windowpicker.displays[display_int]
  else
    return hs.screen.primaryScreen()
  end
end

windowpicker.switch = function(input)

  if input ~= nil then
    windowpicker.placeholderText = "Choose window to activate (Screen " .. input .. ")"
    windowpicker.wfwindows = hs.window.filter.new():setScreens(windowpicker.target_display(input):id()):getWindows()
  else
    windowpicker.placeholderText = "Choose window to activate (All Screens)"
    windowpicker.wfwindows = hs.window.filter.new():getWindows()
  end

  local windows = hs.fnutils.map(windowpicker.wfwindows, function(win)
    if win ~= hs.window.focusedWindow() then
      return {
        text = win:title(),
        subText = win:application():title(),
        image = hs.image.imageFromAppBundle(win:application():bundleID()),
        id = win:id()
      }
    end
  end)

  local chooser = hs.chooser.new(function(choice)
    if choice ~= nil then
      local layout = {}
      local focused = hs.window.focusedWindow()
      local toRead  = hs.window.find(choice.id)
      toRead:focus()
    end
  end)

  chooser
    :placeholderText(windowpicker.placeholderText)
    :searchSubText(true)
    :choices(windows)
    :show()

end

return windowpicker
