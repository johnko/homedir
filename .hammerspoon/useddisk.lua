local useddisk = {}
useddisk.menuBarVisible = false

useddisk.getUsedDiskPercent = function()
  local song = hs.execute("df /System/Volumes/Data | grep '/System/Volumes/Data' | awk '{print $5}'")
  return song
end

useddisk.musicBar = hs.menubar.new()
useddisk.musicTimer = nil
useddisk.showUsedDiskMenuBar = function()
  useddisk.menuBarVisible = true
  local usedDiskPercent = useddisk.getUsedDiskPercent()
  if usedDiskPercent then
    local displayStr = "💾 " .. usedDiskPercent:gsub("^%s*(.-)%s*$", "%1")
    useddisk.musicBar:setTitle(displayStr)
  else
    useddisk.musicBar:setTitle("")
  end
  if useddisk.musicTimer then
    useddisk.musicTimer:start()
  else
    useddisk.musicTimer = hs.timer.doEvery(60, useddisk.showUsedDiskMenuBar)
  end
end

useddisk.menuTable = {
  { title = "Disk Capacity %" },
  -- { title = "-" },
  -- { title = "Refresh", fn = useddisk.showUsedDiskMenuBar }
}
useddisk.musicBar:setMenu(useddisk.menuTable)

useddisk.hideUsedDiskMenuBar = function()
  useddisk.menuBarVisible = false
  useddisk.musicBar:setTitle("")
  useddisk.musicTimer:stop()
end

useddisk.toggleUsedDiskMenuBar = function()
  if useddisk.menuBarVisible then
    useddisk.hideUsedDiskMenuBar()
  else
    useddisk.showUsedDiskMenuBar()
  end
end

return useddisk
