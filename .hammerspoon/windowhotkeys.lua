-- Hotkeys inspired by Starcraft to assign window to shift+ctrl+alt+cmd 1-8 and focus the window with ctrl+alt+cmd 1-8

-- Usage:
-- From ~/.hammerspoon/init.lua
-- local windowhotkeys = require 'windowhotkeys'
-- hs.hotkey.bind({ "ctrl", "alt", "cmd", "shift" }, "1", "Assign Group 1", function()windowhotkeys.assign(1)end)
-- hs.hotkey.bind({ "ctrl", "alt", "cmd", "shift" }, "2", "Assign Group 2", function()windowhotkeys.assign(2)end)
-- hs.hotkey.bind({ "ctrl", "alt", "cmd", "shift" }, "3", "Assign Group 3", function()windowhotkeys.assign(3)end)
-- hs.hotkey.bind({ "ctrl", "alt", "cmd", "shift" }, "4", "Assign Group 4", function()windowhotkeys.assign(4)end)
-- hs.hotkey.bind({ "ctrl", "alt", "cmd", "shift" }, "5", "Assign Group 5", function()windowhotkeys.assign(5)end)
-- hs.hotkey.bind({ "ctrl", "alt", "cmd", "shift" }, "6", "Assign Group 6", function()windowhotkeys.assign(6)end)
-- hs.hotkey.bind({ "ctrl", "alt", "cmd", "shift" }, "7", "Assign Group 7", function()windowhotkeys.assign(7)end)
-- hs.hotkey.bind({ "ctrl", "alt", "cmd", "shift" }, "8", "Assign Group 8", function()windowhotkeys.assign(8)end)
-- hs.hotkey.bind({ "ctrl", "alt", "cmd"          }, "1", "Focus Group 1", function()windowhotkeys.focus(1)end)
-- hs.hotkey.bind({ "ctrl", "alt", "cmd"          }, "2", "Focus Group 2", function()windowhotkeys.focus(2)end)
-- hs.hotkey.bind({ "ctrl", "alt", "cmd"          }, "3", "Focus Group 3", function()windowhotkeys.focus(3)end)
-- hs.hotkey.bind({ "ctrl", "alt", "cmd"          }, "4", "Focus Group 4", function()windowhotkeys.focus(4)end)
-- hs.hotkey.bind({ "ctrl", "alt", "cmd"          }, "5", "Focus Group 5", function()windowhotkeys.focus(5)end)
-- hs.hotkey.bind({ "ctrl", "alt", "cmd"          }, "6", "Focus Group 6", function()windowhotkeys.focus(6)end)
-- hs.hotkey.bind({ "ctrl", "alt", "cmd"          }, "7", "Focus Group 7", function()windowhotkeys.focus(7)end)
-- hs.hotkey.bind({ "ctrl", "alt", "cmd"          }, "8", "Focus Group 8", function()windowhotkeys.focus(8)end)

local windowhotkeys = {}

windowhotkeys.logger = hs.logger.new("windowhotkeys")

---hs.settings key for persisting saved hotkeys, stored as an array of window id
local savedHotkeys <const> = "windowhotkey_saved"

-- save the window to hotkey mapping to settings
windowhotkeys.persist = function ()
  hs.settings.set(savedHotkeys, windowhotkeys.state)
end

-- restore the window to hotkey mapping to settings
windowhotkeys.restore = function ()
  windowhotkeys.state = hs.settings.get(savedHotkeys) or windowhotkeys.emptyState
end

windowhotkeys.start = function()
  windowhotkeys.restore()
end

-- used to assign window using shift+ctrl+alt+cmd 1-8
windowhotkeys.assign = function(input)
  local windowId = hs.window.focusedWindow():id()
  if windowId ~= nil then
    windowhotkeys.state[input] = windowId
    windowhotkeys.persist()
  end
end

-- used to focus window using ctrl+alt+cmd 1-8
windowhotkeys.focus = function(input)
  if windowhotkeys.state[input] ~= nil then
    local window = hs.window.find(windowhotkeys.state[input])
    if window ~= nil then
      window:focus()
    else
      -- clear because we couldn't find window anymore
      windowhotkeys.state[input] = nil
      windowhotkeys.persist()
    end
  end
end

-- init before return
windowhotkeys.emptyState = {}
for _, index in ipairs({1, 2, 3, 4, 5, 6, 7, 8}) do
  windowhotkeys.emptyState[index] = nil
end
windowhotkeys.state = windowhotkeys.emptyState
windowhotkeys.restore()

return windowhotkeys
