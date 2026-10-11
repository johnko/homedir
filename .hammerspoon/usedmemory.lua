local usedmemory = {}
usedmemory.menuBarVisible = false

usedmemory.totalRaw = hs.execute("sysctl -n hw.memsize | awk '{print $1/1024/1024/1024}'")
usedmemory.total = tonumber(usedmemory.totalRaw:gsub("^%s*(.-)%s*$", "%1"), 10)

usedmemory.getUsedDiskPercent = function()
  local usedMemoryRaw = hs.execute("top -l 1 -s 0 | grep 'PhysMem' | grep -o '[0-9A-Z]* used' | sed 's/G used//'")
  local usedMemory = tonumber(usedMemoryRaw:gsub("^%s*(.-)%s*$", "%1"), 10)
  -- local usedMemoryCalc = usedMemory .. "/" .. usedmemory.total .. "%"
  local usedMemoryPercent = (100 * usedMemory // usedmemory.total) .. "%"
  return usedMemoryPercent
end

usedmemory.menuBar = hs.menubar.new()
usedmemory.timer = nil
usedmemory.showUsedDiskMenuBar = function()
  usedmemory.menuBarVisible = true
  local usedMemoryPercent = usedmemory.getUsedDiskPercent()
  if usedMemoryPercent then
    local displayStr = "💡" .. usedMemoryPercent:gsub("^%s*(.-)%s*$", "%1")
    usedmemory.menuBar:setTitle(displayStr)
  else
    usedmemory.menuBar:setTitle("")
  end
  if usedmemory.timer then
    usedmemory.timer:start()
  else
    usedmemory.timer = hs.timer.doEvery(60, usedmemory.showUsedDiskMenuBar)
  end
end

usedmemory.menuTable = {
  { title = "Memory Capacity %" },
  -- { title = "-" },
  -- { title = "Refresh", fn = usedmemory.showUsedDiskMenuBar }
}
usedmemory.menuBar:setMenu(usedmemory.menuTable)

usedmemory.hideUsedDiskMenuBar = function()
  usedmemory.menuBarVisible = false
  usedmemory.menuBar:setTitle("")
  usedmemory.timer:stop()
end

usedmemory.toggleUsedDiskMenuBar = function()
  if usedmemory.menuBarVisible then
    usedmemory.hideUsedDiskMenuBar()
  else
    usedmemory.showUsedDiskMenuBar()
  end
end

return usedmemory
