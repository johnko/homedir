-- AUTOLAYOUT
--
-- Original Source: https://github.com/evantravers/hammerspoon-config/blob/master/autolayout.lua
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

autolayout.target_display = function(display_int)
  -- detect the current number of monitors
  displays = hs.screen.allScreens()
  if displays[display_int] ~= nil then
    return displays[display_int]
  else
    return hs.screen.primaryScreen()
  end
end

autolayout.autoLayout = function()
  for _, app_config in pairs(autolayout.config.applications) do
    -- if we have a preferred display
    if app_config.preferred_display ~= nil then

      autolayout.logger.ef("handling windows for %s", app_config.bundleID)

      application = hs.application.find(app_config.bundleID)

      -- Handle apps with multiple windows
      if application ~= nil then
        for i, window in pairs(application:visibleWindows()) do
          -- autolayout.logger.ef("looping %d, %s", i, window:title())
          window:moveToScreen(autolayout.target_display(app_config.preferred_display), true, true, 0) -- hs.window:moveToScreen(screen[, noResize, ensureInScreenBounds][, duration])
        end
      end

    end
  end
end

-- initialize watchers
autolayout.start = function(config_table)
  autolayout.config = config_table
  if (module) then
    module.config = autolayout.config
  end
end

return autolayout
