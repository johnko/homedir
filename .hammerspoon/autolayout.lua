-- AUTOLAYOUT
--
-- Original Source: https://github.com/evantravers/hammerspoon-config/blob/be5c9284b02f2e509d53385a73e778ba7505532b/autolayout.lua
--
-- This is largely stolen from @megalithic's epic work. This lets application's
-- windows automatically re-settle depending on whether I'm on a single laptop
-- or a dock with an external (and now primary) monitor.
--
-- I prefer applications full screened (for the most part, so this is
-- simplified. I also don't roll with more than two monitors, but this should
-- scale theoretically.
--
-- When you start it, it starts the watcher. You can also trigger an autolayout
-- by calling autolayout.autolayout()
--
-- Expects a table with a key for `applications` with sub-tables with a
-- bundleID and preferred_display:
--
-- Example:
-- config.applications = {
--   ['com.brave.Browser'] = {
--     bundleID = 'com.brave.Browser',
--     preferred_display = 1
--   }
-- }

local autolayout = {}

autolayout.num_of_screens = 0

autolayout.logger = hs.logger.new("autolayout")

-- if not using headspace
autolayout.config = {}

autolayout.target_display = function(table_of_partial_display_name)
  for _k2, partial_display_name in ipairs(table_of_partial_display_name) do
    local screen = hs.screen.find(partial_display_name)
    if screen ~= nil then
      -- autolayout.logger.ef("screen uuid %s", screen:getUUID())
      -- autolayout.logger.ef("screen name %s", screen:name())
      -- autolayout.logger.e("found")
      return screen
    end
  end
  return nil
end

autolayout.autoLayout = function()
  for _k1, screen in ipairs(hs.screen.allScreens()) do
    autolayout.logger.ef("screen uuid %s", screen:getUUID())
    autolayout.logger.ef("screen name %s", screen:name())
  end
  for _, app_config in pairs(autolayout.config.applications) do
    -- if we have a preferred display
    if app_config.preferred_display ~= nil then

      autolayout.logger.f("handling windows for %s", app_config.bundleID)

      autolayout.application = hs.application.find(app_config.bundleID)

      -- Handle apps with multiple windows
      if autolayout.application ~= nil then
        for i, window in pairs(autolayout.application:visibleWindows()) do
          -- autolayout.logger.f("looping %d, %s", i, window:title())
          -- Wrap the potentially erroneous code in an anonymous function for pcall
          local status, message_or_result = pcall(function()
            autolayout.logger.i("Attempting operation...")
            local preferred_display = autolayout.target_display(app_config.preferred_display)
            if preferred_display ~= nil then
              local result = window:moveToScreen(preferred_display, true, true, 0) -- hs.window:moveToScreen(screen[, noResize, ensureInScreenBounds][, duration])
            end
            autolayout.logger.i("Result is: " .. tostring(result)) -- This line will not be reached if an error occurs
          end)
        end
      end

    end
  end
  autolayout.logger.e("DONE autolayout.autoLayout")
end

-- initialize watchers
autolayout.start = function(config_table)
  autolayout.config = config_table
  if (module) then
    module.config = autolayout.config
  end
  autolayout.watcher = hs.screen.watcher.new(autolayout.autoLayout):start()
end

return autolayout
