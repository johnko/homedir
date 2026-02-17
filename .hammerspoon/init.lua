logger = hs.logger.new("MyLocal")

hs.autoLaunch(true)
hs.automaticallyCheckForUpdates(false)
hs.consoleOnTop(false)
hs.dockIcon(true)
hs.menuIcon(true)
hs.uploadCrashData(false)

-- --------------------------------------------------

local mousehighlight = require 'mousehighlight'
hs.hotkey.bind( { "ctrl", "alt", "cmd" }, "`", mousehighlight.mouseHighlight)

-- --------------------------------------------------

-- WarpMouse = hs.loadSpoon("WarpMouse")
-- WarpMouse:start()

-- --------------------------------------------------

PaperWM = nil
-- PaperWM = hs.loadSpoon("PaperWM")
-- PaperWM.external_bar = { bottom = 180 }
-- PaperWM.scroll_gain = 100.0
-- PaperWM.scroll_window = { "cmd" }
-- PaperWM.window_gap = 15
-- PaperWM.window_ratios = { 3/10, 4/9, 6/10, 8/9 }
-- -- number of fingers to detect a horizontal swipe, set to 0 to disable (the default)
-- PaperWM.swipe_fingers = 3
-- PaperWM:bindHotkeys({
--   -- switch to a new focused window in tiled grid
--   focus_left  = { { "ctrl", "alt", "cmd" }, "left" },
--   focus_right = { { "ctrl", "alt", "cmd" }, "right" },
--   focus_up    = { { "ctrl", "alt", "cmd" }, "up" },
--   focus_down  = { { "ctrl", "alt", "cmd" }, "down" },

--   -- switch windows by cycling forward/backward
--   -- (forward = down or right, backward = up or left)
--   focus_prev = { { "ctrl", "alt", "cmd" }, "q" },
--   focus_next = { { "ctrl", "alt", "cmd" }, "e" },

--   -- move windows around in tiled grid
--   swap_column_left  = { { "ctrl", "alt", "cmd", "shift" }, "q" },
--   swap_column_right = { { "ctrl", "alt", "cmd", "shift" }, "e" },
--   swap_left  = { { "ctrl", "alt", "cmd", "shift" }, "left" },
--   swap_right = { { "ctrl", "alt", "cmd", "shift" }, "right" },
--   swap_up    = { { "ctrl", "alt", "cmd", "shift" }, "up" },
--   swap_down  = { { "ctrl", "alt", "cmd", "shift" }, "down" },

--   -- position and resize focused window
--   center_window        = { { "ctrl", "alt", "cmd" }, "5" },
--   cycle_width          = { { "ctrl", "alt", "cmd" }, "r" },
--   reverse_cycle_width  = { { "ctrl", "alt", "cmd", "shift" }, "r" },
--   cycle_height         = { { "ctrl", "alt", "cmd" }, "6" },

--   -- move focused window into / out of a column
--   slurp_in = { { "ctrl", "alt", "cmd" }, "z" },
--   barf_out = { { "ctrl", "alt", "cmd" }, "x" },

--   -- move the focused window into / out of the tiling layer
--   toggle_floating = { { "ctrl", "alt", "cmd" }, "tab" }

-- })
-- PaperWM:start()

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
--     restart_windowmanager.restart(autolayout, PaperWM)
--   end
-- end):start()

hs.urlevent.bind("autolayout", function(eventName, params)
  autolayout.autoLayout()
end)

-- hs.hotkey.bind({ "shift" }, "f16", function()
hs.urlevent.bind("restartwindowmanager", function(eventName, params)
  restart_windowmanager.restart(autolayout, PaperWM)
end)

-- --------------------------------------------------

local terminalswitcher = require 'terminalswitcher'

hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "1", function()terminalswitcher.switch(1)end)
hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "2", function()terminalswitcher.switch(2)end)
hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "3", function()terminalswitcher.switch(3)end)
hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "4", function()terminalswitcher.switch(4)end)
hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "5", function()terminalswitcher.switch(5)end)
hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "6", function()terminalswitcher.switch(6)end)
hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "7", function()terminalswitcher.switch(7)end)
hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "8", function()terminalswitcher.switch(8)end)
