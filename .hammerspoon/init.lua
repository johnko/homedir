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
  swap_column_left  = { { "ctrl", "alt", "cmd", "shift" }, "q" },
  swap_column_right = { { "ctrl", "alt", "cmd", "shift" }, "e" },
  swap_left  = { { "ctrl", "alt", "cmd", "shift" }, "left" },
  swap_right = { { "ctrl", "alt", "cmd", "shift" }, "right" },
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
  ['Google Calendar'] = {
    bundleID = 'com.google.Chrome.app.kjbdgfilnfhdoflbpgamdcdgpehopbep',
    preferred_display = 1,
    tags = {'#collab'}
  },
  ['Podman Desktop'] = {
    bundleID = 'io.podmandesktop.PodmanDesktop',
    preferred_display = 1,
    tags = {'#coding'}
  },
  ['Slack'] = {
    bundleID = 'com.tinyspeck.slackmacgap',
    preferred_display = 1,
    tags = {'#comms'}
  },

  ['Google Chrome'] = {
    bundleID = 'com.google.Chrome',
    preferred_display = 2
  },
  ['Terminal'] = {
    bundleID = 'com.apple.Terminal',
    preferred_display = 2,
    tags = {'#coding'}
  },
  ['Visual Studio Code'] = {
    bundleID = 'com.microsoft.VSCode',
    preferred_display = 2,
    tags = {'#coding'}
  },

  ['Discord'] = {
    bundleID = 'com.hnc.Discord',
    preferred_display = 3,
    tags = {'#games'}
  },
  ['Line'] = {
    bundleID = 'jp.naver.line.mac',
    preferred_display = 3,
    tags = {'#comms'}
  },
  ['Messages'] = {
    bundleID = 'com.apple.MobileSMS',
    preferred_display = 3,
    tags = {'#comms'}
  },
  ['Signal'] = {
    bundleID = 'org.whispersystems.signal-desktop',
    preferred_display = 3,
    tags = {'#comms'}
  }
}

local autolayout = require 'autolayout'
      autolayout.start(config)

runtimeConfig = {}
runtimeConfig.running = false
runtimeConfig.restartedPaperWM = false
runtimeConfig.restartedAutolayout = false
if not runtimeConfig.num_of_screens then
  runtimeConfig.num_of_screens = 0
end

restart_spoons = function()
  if runtimeConfig.running == false then
    runtimeConfig.running = true
    logger.e("3 Called restart_spoons")
    runtimeConfig.num_of_screens = #hs.screen.allScreens()
    logger.ef("4 New runtimeConfig.num_of_screens: %d", runtimeConfig.num_of_screens)
    runtimeConfig.restartedPaperWM = false
    runtimeConfig.restartedAutolayout = false
    PaperWM:stop()

    hs.timer.doUntil(function()
      return runtimeConfig.restartedAutolayout
    end,
    function()
      logger.e("5 Called autolayout.autoLayout")
      autolayout.autoLayout()
      runtimeConfig.restartedAutolayout = true
      logger.e("5 END")
    end):start()

    hs.timer.doUntil(function()
      return runtimeConfig.restartedPaperWM
    end,
    function()
      logger.e("6 Called PaperWM:start")
      if runtimeConfig.restartedAutolayout then
        PaperWM:start()
        -- hs.reload()
        runtimeConfig.restartedPaperWM = true
        runtimeConfig.running = false
        logger.ef("6 DONE runtimeConfig.running: %s", runtimeConfig.running)
      end
    end):start()

  end
end

hs.screen.watcher.newWithActiveScreen(function(activeScreenChanged)
  logger.e("1 Called from screen.watcher")
  logger.ef("2 runtimeConfig.num_of_screens: %d", runtimeConfig.num_of_screens)
  if activeScreenChanged == nil then
    restart_spoons()
  end
end):start()

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "y", function()
  logger.e("1 Called from hotkey")
  logger.ef("2 runtimeConfig.num_of_screens: %d", runtimeConfig.num_of_screens)
  restart_spoons()
end)

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "m", function()
  logger.e("1 Called from hotkey")
  logger.ef("2 runtimeConfig.num_of_screens: %d", runtimeConfig.num_of_screens)
  autolayout.autoLayout()
end)
