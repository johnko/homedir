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

local terminalswitcher = require 'terminalswitcher'

hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "1", "Group 1", function()terminalswitcher.switch(1)end)
hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "2", "Group 2", function()terminalswitcher.switch(2)end)
hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "3", "Group 3", function()terminalswitcher.switch(3)end)
hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "4", "Group 4", function()terminalswitcher.switch(4)end)
hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "5", "Group 5", function()terminalswitcher.switch(5)end)
hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "6", "Group 6", function()terminalswitcher.switch(6)end)
hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "7", "Group 7", function()terminalswitcher.switch(7)end)
hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "8", "Group 8", function()terminalswitcher.switch(8)end)
