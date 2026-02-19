-- Hotkeys inspired by Starcraft to assign window to shift+ctrl+alt+cmd 1-8 and focus the window with ctrl+alt+cmd 1-8

-- Usage:
--

local windowhotkeys = {}

windowhotkeys.logger = hs.logger.new("windowhotkeys")

windowhotkeys.emptyState = {}
for _, index in ipairs({1, 2, 3, 4, 5, 6, 7, 8}) do
  windowhotkeys.emptyState[index] = nil
end
windowhotkeys.state = windowhotkeys.emptyState

---hs.settings key for persisting saved hotkeys, stored as an array of window id
local savedHotkeys <const> = "windowhotkey_saved"

-- save the window to hotkey mapping to settings
windowhotkeys.persist = function ()
  hs.settings.set(savedHotkeys, windowhotkeys.state)
end

-- restore the window to hotkey mapping to settings
windowhotkeys.restore = function ()
  windowhotkeys.state = hs.settings.get(savedHotkeys) or windowhotkeys.emptyState
  for _, id in ipairs(persisted) do
    local window = hs.window.get(id)
  end
  windowhotkeys.persist()
end

-- used to assign window using shift+ctrl+alt+cmd 1-8
windowhotkeys.assign = function(input)
  local windowId = hs.window.focusedWindow():id()
  if windowId ~= nil then
    windowhotkeys.state[input] = windowId
  end
end

-- used to focus window using ctrl+alt+cmd 1-8
windowhotkeys.focus = function(input)
  if windowhotkeys.state[input] ~= nil then
    local window = hs.window.find(windowhotkeys.state[input])
    if window ~= nil then
      window:focus()
    end
  end
end

windowhotkeys.start = function()
  windowhotkeys.restore()
end

return windowhotkeys
