-- Hotkeys inspired by Starcraft to assign window to shift+ctrl+alt+cmd 1-8 and focus the window with ctrl+alt+cmd 1-8

-- Usage:
-- From ~/.hammerspoon/init.lua
-- local windowhotkeys = require 'windowhotkeys'
-- hs.hotkey.bind({ "ctrl", "alt", "cmd", "shift" }, "1", "Assign Window 1", function()windowhotkeys.assign(1)end)
-- hs.hotkey.bind({ "ctrl", "alt", "cmd", "shift" }, "2", "Assign Window 2", function()windowhotkeys.assign(2)end)
-- hs.hotkey.bind({ "ctrl", "alt", "cmd", "shift" }, "3", "Assign Window 3", function()windowhotkeys.assign(3)end)
-- hs.hotkey.bind({ "ctrl", "alt", "cmd", "shift" }, "4", "Assign Window 4", function()windowhotkeys.assign(4)end)
-- hs.hotkey.bind({ "ctrl", "alt", "cmd", "shift" }, "5", "Assign Window 5", function()windowhotkeys.assign(5)end)
-- hs.hotkey.bind({ "ctrl", "alt", "cmd", "shift" }, "6", "Assign Window 6", function()windowhotkeys.assign(6)end)
-- hs.hotkey.bind({ "ctrl", "alt", "cmd", "shift" }, "7", "Assign Window 7", function()windowhotkeys.assign(7)end)
-- hs.hotkey.bind({ "ctrl", "alt", "cmd", "shift" }, "8", "Assign Window 8", function()windowhotkeys.assign(8)end)
-- hs.hotkey.bind({ "ctrl", "alt", "cmd", "shift" }, "9", "Assign Window 9", function()windowhotkeys.assign(9)end)
-- hs.hotkey.bind({ "ctrl", "alt", "cmd"          }, "1", "Focus Window 1", function()windowhotkeys.focus(1)end)
-- hs.hotkey.bind({ "ctrl", "alt", "cmd"          }, "2", "Focus Window 2", function()windowhotkeys.focus(2)end)
-- hs.hotkey.bind({ "ctrl", "alt", "cmd"          }, "3", "Focus Window 3", function()windowhotkeys.focus(3)end)
-- hs.hotkey.bind({ "ctrl", "alt", "cmd"          }, "4", "Focus Window 4", function()windowhotkeys.focus(4)end)
-- hs.hotkey.bind({ "ctrl", "alt", "cmd"          }, "5", "Focus Window 5", function()windowhotkeys.focus(5)end)
-- hs.hotkey.bind({ "ctrl", "alt", "cmd"          }, "6", "Focus Window 6", function()windowhotkeys.focus(6)end)
-- hs.hotkey.bind({ "ctrl", "alt", "cmd"          }, "7", "Focus Window 7", function()windowhotkeys.focus(7)end)
-- hs.hotkey.bind({ "ctrl", "alt", "cmd"          }, "8", "Focus Window 8", function()windowhotkeys.focus(8)end)
-- hs.hotkey.bind({ "ctrl", "alt", "cmd"          }, "9", "Focus Window 9", function()windowhotkeys.focus(9)end)
-- windowhotkeys.start({'6167F4D1-86CB-42BC-97D9-37FCE9CE14EE', 'Built', '(1)', 'U32'})

local windowhotkeys = {}

windowhotkeys.logger = hs.logger.new("windowhotkeys")
windowhotkeys.canvas = nil
windowhotkeys.table_of_partial_display_name = nil

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
      windowhotkeys.persist()
    end
  end
end

-- init before return
windowhotkeys.emptyState = {}
for _, index in ipairs({1, 2, 3, 4, 5, 6, 7, 8, 9}) do
  windowhotkeys.emptyState[index] = nil
end
windowhotkeys.state = windowhotkeys.emptyState
windowhotkeys.restore()

windowhotkeys.target_display = function(table_of_partial_display_name)
  -- for _k1, screen in ipairs(hs.screen.allScreens()) do
    -- windowhotkeys.logger.ef("screen uuid %s", screen:getUUID())
    -- windowhotkeys.logger.ef("screen name %s", screen:name())
  -- end
  for _k2, partial_display_name in ipairs(table_of_partial_display_name) do
    local screen = hs.screen.find(partial_display_name)
    if screen ~= nil then
      -- windowhotkeys.logger.ef("screen uuid %s", screen:getUUID())
      -- windowhotkeys.logger.ef("screen name %s", screen:name())
      -- windowhotkeys.logger.e("found")
      return screen
    end
  end
  return hs.screen.primaryScreen()
end

-- draw helper data
windowhotkeys.drawInfo = function()
  local lines = {}

  for index, id in ipairs(windowhotkeys.state) do
    local canvasImageIndex = 2 + index
    win = hs.window(id)
    if win ~= nil then
      text = hs.utf8.asciiOnly(
        win:title():gsub("—","-"):gsub("▸",">"):gsub("⌥⌘","OptCmd"):gsub("•","*")
      ):gsub("\\x..","_")
      :gsub("__","_")
      :gsub("__","_")
      :gsub("__","_")
      :gsub("__","_")
      -- windowhotkeys.logger.e(text)
      subText = hs.utf8.asciiOnly(win:application():title())
      windowhotkeys.canvas[canvasImageIndex].image = hs.image.imageFromAppBundle(win:application():bundleID())
      table.insert(
        lines,
        index .. "        " .. string.sub(text, 1, 30) ..
              "\n         " .. string.sub(subText, 1, 30) .. "\n"
    )
    else
      windowhotkeys.canvas[canvasImageIndex].image = nil
      table.insert(lines, index .. "\n\n")
    end
  end

  windowhotkeys.canvas[2].text = table.concat(lines, "\n")
end

-- draw helper canvas container
windowhotkeys.createCanvas = function()
  if windowhotkeys.canvas then
    windowhotkeys.canvas:hide()
  end
  windowhotkeys.screen = windowhotkeys.target_display(windowhotkeys.table_of_partial_display_name)
  local frame = windowhotkeys.screen:frame()
  local fullFrame = windowhotkeys.screen:fullFrame()
  local canvasW = 350
  local canvasX = fullFrame.w - canvasW
  windowhotkeys.canvas = hs.canvas.new({
    x = canvasX,
    y = frame.y,
    w = canvasW + 1,
    h = frame.h,
  })
  windowhotkeys.canvas[1] = {
    type = "rectangle",
    action = "fill",
    fillColor = {hex="#000000"},
  }
  windowhotkeys.canvas[2] = {
    type = "text",
    frame = {x=10, y=10, h="100%", w="100%"},
    textFont = "Monaco",
    textSize = 13,
    textColor = {hex="#ffffff"},
  }
  for index, _ in ipairs({1, 2, 3, 4, 5, 6, 7, 8, 9}) do
    local canvasImageIndex = 2 + index
    windowhotkeys.canvas[canvasImageIndex] = {
      type  = "image",
      frame = {x=22, y=((index-1)*48), w=50, h=50},
      action = "fill",
    }
  end
  windowhotkeys.canvas:show()
  windowhotkeys.canvas:sendToBack()
  windowhotkeys.drawInfo()
end

-- initialize watchers
windowhotkeys.start = function(table_of_partial_display_name)
  windowhotkeys.table_of_partial_display_name = table_of_partial_display_name
  windowhotkeys.createCanvas()
  -- Start over when any screen geometry changes.
  windowhotkeys.watcher = hs.screen.watcher.newWithActiveScreen(windowhotkeys.createCanvas):start()
  -- Redraw every few seconds.
  windowhotkeys.timer = hs.timer.doEvery(2, windowhotkeys.drawInfo):start()
end

return windowhotkeys
