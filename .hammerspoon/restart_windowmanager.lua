restart_windowmanager = {}
restart_windowmanager.runtimeConfig = {}
restart_windowmanager.runtimeConfig.running = false
restart_windowmanager.runtimeConfig.restartedPaperWM = false
restart_windowmanager.runtimeConfig.restartedAutolayout = false

restart_windowmanager.logger = hs.logger.new("restart_windowmanager")

restart_windowmanager.restart = function(autolayout, PaperWM)
  if restart_windowmanager.runtimeConfig.running == false then
    restart_windowmanager.runtimeConfig.running = true
    restart_windowmanager.logger.i("Called restart_windowmanager.restart")
    restart_windowmanager.runtimeConfig.restartedPaperWM = false
    restart_windowmanager.runtimeConfig.restartedAutolayout = false
    if PaperWM ~= nil then
      PaperWM:stop()
    end

    hs.timer.doUntil(function()
      return restart_windowmanager.runtimeConfig.restartedAutolayout
    end,
    function()
      restart_windowmanager.logger.i("Calling autolayout.autoLayout")
      if autolayout ~= nil then
        autolayout.autoLayout()
      end
      restart_windowmanager.runtimeConfig.restartedAutolayout = true
    end):start()

    hs.timer.doUntil(function()
      return restart_windowmanager.runtimeConfig.restartedPaperWM
    end,
    function()
      restart_windowmanager.logger.i("Calling PaperWM:start")
      if restart_windowmanager.runtimeConfig.restartedAutolayout then
        if PaperWM ~= nil then
          PaperWM:start()
        else
          hs.reload()
        end
        restart_windowmanager.runtimeConfig.restartedPaperWM = true
        restart_windowmanager.runtimeConfig.running = false
        restart_windowmanager.logger.e("DONE restart_windowmanager.restart")
      end
    end):start()

  end
end

return restart_windowmanager
