logger = hs.logger.new("MyLocal")

hs.autoLaunch(true)
hs.automaticallyCheckForUpdates(false)
hs.consoleOnTop(false)
hs.dockIcon(true)
hs.menuIcon(true)
hs.uploadCrashData(false)
hs.window.animationDuration = 0

-- --------------------------------------------------

local mousehighlight = require 'mousehighlight'
hs.hotkey.bind( { "ctrl", "alt", "cmd" }, "`", "Mouse & Notifications", mousehighlight.mouseHighlight)

-- --------------------------------------------------

-- hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "n", function()
hs.urlevent.bind("movetonextscreen", function(eventName, params)
  local focusedWindow = hs.window.focusedWindow()
  local screen = focusedWindow:screen()
  -- if screen is same resolution this preserves position and size
  -- hs.window:moveToScreen(screen[, noResize, ensureInScreenBounds][, duration])
  focusedWindow:moveToScreen(screen:next(), true, true, 0)
end)

-- --------------------------------------------------

config = require 'applications_preferred_display'

local autolayout = require 'autolayout'
autolayout.start(config)

restart_windowmanager = require 'restart_windowmanager'

-- hs.screen.watcher.newWithActiveScreen(function(activeScreenChanged)
--   logger.i("Called from screen.watcher")
--   if activeScreenChanged == nil then
--     restart_windowmanager.restart(autolayout, nil)
--   end
-- end):start()

hs.urlevent.bind("autolayout", function(eventName, params)
  autolayout.autoLayout()
end)

-- hs.hotkey.bind({ "shift" }, "f16", function()
hs.urlevent.bind("restartwindowmanager", function(eventName, params)
  restart_windowmanager.restart(autolayout, nil)
end)

-- --------------------------------------------------

hs.urlevent.bind("movetotopofscreen", function(eventName, params)
  logger.i("Called from movetotopofscreen")
  local focusedWindow = hs.window.focusedWindow()
  local screen = focusedWindow:screen()
  local screenFrame = screen:frame()
  local windowFrame = focusedWindow:frame()
  local topY = (10 + screenFrame.y - windowFrame.y)
  logger.f("windowFrame y %d", topY)
  if topY < -50 then
    -- to top of screen
    focusedWindow:move(windowFrame:move(0, 10 + screenFrame.y - windowFrame.y), screen, true, 0)
  else
    -- to top of yabai obeying padding
    focusedWindow:move(windowFrame:move(0, 101 + screenFrame.y - windowFrame.y), screen, true, 0)
  end
end)

-- --------------------------------------------------

local windowpicker = require 'windowpicker'
hs.hotkey.bind({ "ctrl", "alt", "cmd"          }, "tab", "Window picker, All Screens"                          , function()windowpicker.switch(nil)end)
hs.hotkey.bind({ "ctrl", "alt", "cmd"          }, "z",   "Window picker, Screen " .. config.screen.top_left    , function()windowpicker.switch(config.screen.top_left)end)
hs.hotkey.bind({ "ctrl", "alt", "cmd", "shift" }, "z",   "Window picker, Screen " .. config.screen.bottom_left , function()windowpicker.switch(config.screen.bottom_left)end)
hs.hotkey.bind({ "ctrl", "alt", "cmd"          }, "x",   "Window picker, Screen " .. config.screen.bottom_right, function()windowpicker.switch(config.screen.bottom_right)end)
hs.hotkey.bind({ "ctrl", "alt", "cmd", "shift" }, "x",   "Window picker, Screen 4"                             , function()windowpicker.switch(4)end)

-- --------------------------------------------------

local windowhotkeys = require 'windowhotkeys'
hs.hotkey.bind({ "ctrl", "alt", "cmd", "shift" }, "1", "Assign Group 1", function()windowhotkeys.assign(1)end)
hs.hotkey.bind({ "ctrl", "alt", "cmd", "shift" }, "2", "Assign Group 2", function()windowhotkeys.assign(2)end)
hs.hotkey.bind({ "ctrl", "alt", "cmd", "shift" }, "3", "Assign Group 3", function()windowhotkeys.assign(3)end)
hs.hotkey.bind({ "ctrl", "alt", "cmd", "shift" }, "4", "Assign Group 4", function()windowhotkeys.assign(4)end)
hs.hotkey.bind({ "ctrl", "alt", "cmd", "shift" }, "5", "Assign Group 5", function()windowhotkeys.assign(5)end)
hs.hotkey.bind({ "ctrl", "alt", "cmd", "shift" }, "6", "Assign Group 6", function()windowhotkeys.assign(6)end)
hs.hotkey.bind({ "ctrl", "alt", "cmd", "shift" }, "7", "Assign Group 7", function()windowhotkeys.assign(7)end)
hs.hotkey.bind({ "ctrl", "alt", "cmd", "shift" }, "8", "Assign Group 8", function()windowhotkeys.assign(8)end)
hs.hotkey.bind({ "ctrl", "alt", "cmd"          }, "1", "Focus Group 1", function()windowhotkeys.focus(1)end)
hs.hotkey.bind({ "ctrl", "alt", "cmd"          }, "2", "Focus Group 2", function()windowhotkeys.focus(2)end)
hs.hotkey.bind({ "ctrl", "alt", "cmd"          }, "3", "Focus Group 3", function()windowhotkeys.focus(3)end)
hs.hotkey.bind({ "ctrl", "alt", "cmd"          }, "4", "Focus Group 4", function()windowhotkeys.focus(4)end)
hs.hotkey.bind({ "ctrl", "alt", "cmd"          }, "5", "Focus Group 5", function()windowhotkeys.focus(5)end)
hs.hotkey.bind({ "ctrl", "alt", "cmd"          }, "6", "Focus Group 6", function()windowhotkeys.focus(6)end)
hs.hotkey.bind({ "ctrl", "alt", "cmd"          }, "7", "Focus Group 7", function()windowhotkeys.focus(7)end)
hs.hotkey.bind({ "ctrl", "alt", "cmd"          }, "8", "Focus Group 8", function()windowhotkeys.focus(8)end)
