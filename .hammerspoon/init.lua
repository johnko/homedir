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
  swap_left  = { { "ctrl", "alt", "cmd" }, "1" },
  swap_right = { { "ctrl", "alt", "cmd" }, "2" },
  swap_up    = { { "ctrl", "alt", "cmd", "shift" }, "up" },
  swap_down  = { { "ctrl", "alt", "cmd", "shift" }, "down" },

  -- position and resize focused window
  center_window        = { { "ctrl", "alt", "cmd", "shift" }, "g" },
  full_width           = { { "ctrl", "alt", "cmd" }, "5" },
  cycle_width          = { { "ctrl", "alt", "cmd" }, "r" },
  reverse_cycle_width  = { { "ctrl", "alt", "cmd", "shift" }, "r" },
  cycle_height         = { { "ctrl", "alt", "cmd" }, "6" },
  reverse_cycle_height = { { "ctrl", "alt", "cmd", "shift" }, "6" },

  -- move focused window into / out of a column
  slurp_in = { { "ctrl", "alt", "cmd" }, "z" },
  barf_out = { { "ctrl", "alt", "cmd" }, "x" },

  -- move the focused window into / out of the tiling layer
  toggle_floating = { { "ctrl", "alt", "cmd" }, "tab" }

})
PaperWM:start()
