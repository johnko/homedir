logger = hs.logger.new("MyLocal")

hs.autoLaunch(true)
hs.automaticallyCheckForUpdates(false)
hs.consoleOnTop(false)
hs.dockIcon(true)
hs.menuIcon(true)
hs.uploadCrashData(false)

-- --------------------------------------------------

WarpMouse = hs.loadSpoon("WarpMouse")
WarpMouse:start()

PaperWM = hs.loadSpoon("PaperWM")
PaperWM.external_bar = { bottom = 180 }
PaperWM.scroll_gain = 100.0
PaperWM.scroll_window = { "cmd" }
PaperWM.window_gap = 15
-- PaperWM.window_ratios = { 1/4, 1/3, 2/4, 2/3, 3/4 }
PaperWM.window_ratios = { 1/4, 2/4, 3/4 }
-- number of fingers to detect a horizontal swipe, set to 0 to disable (the default)
PaperWM.swipe_fingers = 3
PaperWM:bindHotkeys({
  -- switch to a new focused window in tiled grid
  focus_left  = { { "ctrl", "alt", "cmd" }, "left" },
  focus_right = { { "ctrl", "alt", "cmd" }, "right" },
  focus_up    = { { "ctrl", "alt", "cmd" }, "up" },
  focus_down  = { { "ctrl", "alt", "cmd" }, "down" },

  -- switch windows by cycling forward/backward
  -- (forward = down or right, backward = up or left)
  focus_prev = { { "ctrl", "alt", "cmd" }, "q" },
  focus_next = { { "ctrl", "alt", "cmd" }, "e" },

  -- move windows around in tiled grid
  swap_left  = { { "ctrl", "alt", "cmd", "shift" }, "q" },
  swap_right = { { "ctrl", "alt", "cmd", "shift" }, "e" },
  swap_up    = { { "ctrl", "alt", "cmd", "shift" }, "up" },
  swap_down  = { { "ctrl", "alt", "cmd", "shift" }, "down" },

  -- position and resize focused window
  center_window        = { { "ctrl", "alt", "cmd", "shift" }, "tab" },
  full_width           = { { "ctrl", "alt", "cmd" }, "5" },
  cycle_width          = { { "ctrl", "alt", "cmd" }, "r" },
  reverse_cycle_width  = { { "ctrl", "alt", "cmd", "shift" }, "r" },
  cycle_height         = { { "ctrl", "alt", "cmd" }, "6" },

  -- move focused window into / out of a column
  slurp_in = { { "ctrl", "alt", "cmd" }, "z" },
  barf_out = { { "ctrl", "alt", "cmd" }, "x" },

  -- move the focused window into / out of the tiling layer
  toggle_floating = { { "ctrl", "alt", "cmd" }, "tab" }

})
PaperWM:start()

-- --------------------------------------------------

config = {}
config.applications = {
  ['Brave'] = {
    bundleID = 'com.brave.Browser',
    preferred_display = 1
  },
  ['Firefox'] = {
    bundleID = 'org.mozilla.firefox',
    preferred_display = 1
  },
  ['Discord'] = {
    bundleID = 'com.hnc.Discord',
    preferred_display = 3,
    tags = {'#games'}
  },
  ['Visual Studio Code'] = {
    bundleID = 'com.microsoft.VSCode',
    preferred_display = 2,
    tags = {'#coding'}
  },
  ['Line'] = {
    bundleID = 'jp.naver.line.mac',
    preferred_display = 3,
    tags = {'#communication'}
  },
  ['Messages'] = {
    bundleID = 'com.apple.MobileSMS',
    preferred_display = 3,
    tags = {'#communication'}
  },
  ['Signal'] = {
    bundleID = 'org.whispersystems.signal-desktop',
    preferred_display = 3,
    tags = {'#communication'}
  },
  ['Slack'] = {
    bundleID = 'com.tinyspeck.slackmacgap',
    preferred_display = 1,
    tags = {'#communication'}
  }
}

local autolayout = require 'autolayout'
      autolayout.start(config)

if not num_of_screens then
  num_of_screens = 0
end
logger.ef("0 num_of_screens: %d", num_of_screens)

restart_spoons = function()
  logger.e("4 Called restart_spoons")
  num_of_screens = #hs.screen.allScreens()
  PaperWM:stop()
  for _, seconds in ipairs({1, 2, 4}) do
    if seconds < 4 then
      hs.timer.doAfter(seconds, function()
        logger.ef("5 Called autolayout.autoLayout %d", seconds)
        autolayout.autoLayout()
      end)
    else
      hs.timer.doAfter(seconds, function()
        logger.ef("6 Called PaperWM:start %d", seconds)
        PaperWM:start()
        -- hs.reload()
      end)
    end
  end
end

hs.screen.watcher.newWithActiveScreen(function()
  logger.e("1 Called from screen.watcher")
  logger.ef("2 num_of_screens: %d", num_of_screens)
  if num_of_screens ~= #hs.screen.allScreens() then
    num_of_screens = #hs.screen.allScreens()
    logger.ef("3 New num_of_screens: %d", num_of_screens)
    restart_spoons()
  end
end):start()

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "y", function()
  logger.e("1 Called from hotkey")
  logger.ef("2 num_of_screens: %d", num_of_screens)
  restart_spoons()
end)
