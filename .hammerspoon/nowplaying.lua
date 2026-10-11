local nowplaying = {}
nowplaying.logger = hs.logger.new("nowplaying")
nowplaying.menuBarVisible = false
nowplaying.menuBar = hs.menubar.new()
nowplaying.menuTable = {
  { title = "Now playing" },
--   { title = "-" },
}
nowplaying.menuBar:setMenu(nowplaying.menuTable)

nowplaying.getNowPlaying = function()
  local song = hs.execute("/opt/homebrew/bin/nowplaying-cli get title artist")
  return song
end

nowplaying.alertNowPlaying = function()
  local song = nowplaying.getNowPlaying()
  if song then
      local displayStr = ("🎵 " .. string.gsub(song, "\n", " - ", 1)):gsub("^%s*(.-)%s*$", "%1")
      hs.alert.show(displayStr)
  end
end

nowplaying.updateNowPlayingMenuBar = function()
  local song = nowplaying.getNowPlaying()
  if song then
    local displayStr = ("♫ " .. string.gsub(song, "\n", " - ", 1)):gsub("^%s*(.-)%s*$", "%1")
    nowplaying.menuBar:setTitle(displayStr)
  else
    nowplaying.menuBar:setTitle("")
  end
end

nowplaying.taskCallbackGetPlaybackRate = function(exitCode, stdOut, stdErr)
  -- nowplaying.logger.e("taskCallbackGetPlaybackRate...")
  if exitCode == 0 then
    local rate = stdOut:gsub("^%s*(.-)%s*$", "%1")
    -- nowplaying.logger.e(rate)
    if rate == "1" then
      nowplaying.updateNowPlayingMenuBar()
    else
      nowplaying.menuBar:setTitle("")
    end
  end
end

nowplaying.taskRunnerGetPlaybackRate = function()
  if nowplaying.menuBarVisible then
    -- nowplaying.logger.e("taskRunnerGetPlaybackRate...")
    nowplaying.taskGetPlaybackRate = hs.task.new("/opt/homebrew/bin/nowplaying-cli", nowplaying.taskCallbackGetPlaybackRate, {"get", "playbackRate"})
    nowplaying.taskGetPlaybackRate:start()
  end
end

nowplaying.timer = hs.timer.doEvery(4, nowplaying.taskRunnerGetPlaybackRate)

nowplaying.showNowPlayingMenuBar = function()
  nowplaying.menuBarVisible = true
  nowplaying.taskRunnerGetPlaybackRate()
  nowplaying.timer:start()
end

nowplaying.hideNowPlayingMenuBar = function()
  nowplaying.menuBarVisible = false
  nowplaying.menuBar:setTitle("")
  nowplaying.timer:stop()
end

nowplaying.toggleNowPlayingMenuBar = function()
  if nowplaying.menuBarVisible then
    nowplaying.hideNowPlayingMenuBar()
  else
    nowplaying.showNowPlayingMenuBar()
  end
end

return nowplaying
