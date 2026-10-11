local useddisk = {}
useddisk.menuBarVisible = false

useddisk.getUsedDiskPercent = function()
  local usedDiskPercent = hs.execute("df /System/Volumes/Data | grep '/System/Volumes/Data' | awk '{print $5}'")
  return usedDiskPercent
end

useddisk.menuBar = hs.menubar.new()
useddisk.timer = nil
useddisk.showUsedDiskMenuBar = function()
  useddisk.menuBarVisible = true
  local usedDiskPercent = useddisk.getUsedDiskPercent()
  if usedDiskPercent then
    local displayStr = "💾 " .. usedDiskPercent:gsub("^%s*(.-)%s*$", "%1")
    useddisk.menuBar:setTitle(displayStr)
  else
    useddisk.menuBar:setTitle("")
  end
  if useddisk.timer then
    useddisk.timer:start()
  else
    useddisk.timer = hs.timer.doEvery(60, useddisk.showUsedDiskMenuBar)
  end
end

useddisk.menuTable = {
  { title = "Disk Capacity %" },
  -- { title = "-" },
  -- { title = "Refresh", fn = useddisk.showUsedDiskMenuBar }
}
useddisk.menuBar:setMenu(useddisk.menuTable)

useddisk.hideUsedDiskMenuBar = function()
  useddisk.menuBarVisible = false
  useddisk.menuBar:setTitle("")
  useddisk.timer:stop()
end

useddisk.toggleUsedDiskMenuBar = function()
  if useddisk.menuBarVisible then
    useddisk.hideUsedDiskMenuBar()
  else
    useddisk.showUsedDiskMenuBar()
  end
end

return useddisk
