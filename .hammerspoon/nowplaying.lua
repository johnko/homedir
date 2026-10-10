local nowplaying = {}

nowplaying.getNowPlaying = function()
  local song = hs.execute("/opt/homebrew/bin/nowplaying-cli get title artist")
  return song
end

nowplaying.alertNowPlaying = function()
  local song = nowplaying.getNowPlaying()
  if song then
      local displayStr = "🎵 " .. string.gsub(song, "\n", " - ", 1)
      hs.alert.show(displayStr:gsub("^%s*(.-)%s*$", "%1"))
  end
end

return nowplaying
