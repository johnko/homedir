-- Window chooser

-- Original Source: https://github.com/evantravers/hammerspoon-config/blob/be5c9284b02f2e509d53385a73e778ba7505532b/movewindows.lua

local windowpicker = {}

windowpicker.logger = hs.logger.new("windowpicker")

windowpicker.target_display = function(table_of_partial_display_name)
  -- for _k1, screen in ipairs(hs.screen.allScreens()) do
    -- windowpicker.logger.ef("screen uuid %s", screen:getUUID())
    -- windowpicker.logger.ef("screen name %s", screen:name())
  -- end
  for _k2, partial_display_name in ipairs(table_of_partial_display_name) do
    local screen = hs.screen.find(partial_display_name)
    if screen ~= nil then
      windowpicker.logger.ef("screen uuid %s", screen:getUUID())
      windowpicker.logger.ef("screen name %s", screen:name())
      windowpicker.logger.e("found")
      return screen
    end
  end
  return hs.screen.primaryScreen()
end

windowpicker.switch = function(input)
  local placeholderText = nil
  local wfwindows = nil
  if input ~= nil then
    local preferred_display = windowpicker.target_display(input)
    if preferred_display ~= nil then
      placeholderText = "Choose window to activate (" .. preferred_display:name() .. ")"
      wfwindows = hs.window.filter.new():setScreens(preferred_display:id()):getWindows()
    end
  end

  if placeholderText == nil then
    placeholderText = "Choose window to activate (All Screens)"
    wfwindows = hs.window.filter.new():getWindows()
  end

  local windows = hs.fnutils.map(wfwindows, function(win)
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
    :placeholderText(placeholderText)
    :searchSubText(true)
    :choices(windows)
    :show()

end

return windowpicker
