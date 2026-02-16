restart_windowmanager = {}
restart_windowmanager.runtimeConfig = {}
restart_windowmanager.runtimeConfig.running = false
restart_windowmanager.runtimeConfig.restartedPaperWM = false
restart_windowmanager.runtimeConfig.restartedAutolayout = false

restart_windowmanager.restart = function(autolayout, PaperWM)
  if restart_windowmanager.runtimeConfig.running == false then
    restart_windowmanager.runtimeConfig.running = true
    logger.e("2 Called restart_windowmanager.restart")
    restart_windowmanager.runtimeConfig.restartedPaperWM = false
    restart_windowmanager.runtimeConfig.restartedAutolayout = false
    PaperWM:stop()

    hs.timer.doUntil(function()
      return restart_windowmanager.runtimeConfig.restartedAutolayout
    end,
    function()
      logger.e("4 Called autolayout.autoLayout")
      autolayout.autoLayout()
      restart_windowmanager.runtimeConfig.restartedAutolayout = true
      logger.e("4 END")
    end):start()

    hs.timer.doUntil(function()
      return restart_windowmanager.runtimeConfig.restartedPaperWM
    end,
    function()
      logger.e("5 Called PaperWM:start")
      if restart_windowmanager.runtimeConfig.restartedAutolayout then
        PaperWM:start()
        -- hs.reload()
        restart_windowmanager.runtimeConfig.restartedPaperWM = true
        restart_windowmanager.runtimeConfig.running = false
        logger.e("6 DONE")
      end
    end):start()

  end
end

return restart_windowmanager
