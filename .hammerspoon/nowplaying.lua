local nowplaying = {}
nowplaying.menuBarVisible = false

nowplaying.getPlaybackRate = function()
  local rate = hs.execute("/opt/homebrew/bin/nowplaying-cli get playbackRate")
  return rate:gsub("^%s*(.-)%s*$", "%1")
end

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

nowplaying.menuBar = hs.menubar.new()
nowplaying.timer = nil
nowplaying.showNowPlayingMenuBar = function()
  nowplaying.menuBarVisible = true
  local song = nowplaying.getNowPlaying()
  local rate = nowplaying.getPlaybackRate()
  if rate == "1" then
    if song then
      local displayStr = ("♫ " .. string.gsub(song, "\n", " - ", 1)):gsub("^%s*(.-)%s*$", "%1")
      nowplaying.menuBar:setTitle(displayStr)
    else
      nowplaying.menuBar:setTitle("")
    end
  else
    nowplaying.menuBar:setTitle("")
  end
  if nowplaying.timer then
    nowplaying.timer:start()
  else
    nowplaying.timer = hs.timer.doEvery(1, nowplaying.showNowPlayingMenuBar)
  end
end

nowplaying.menuTable = {
  { title = "Now playing" },
--   { title = "-" },
--   { title = "Refresh", fn = nowplaying.showNowPlayingMenuBar }
}
nowplaying.menuBar:setMenu(nowplaying.menuTable)

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
