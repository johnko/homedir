local usedmemory = {}
usedmemory.logger = hs.logger.new("usedmemory")
usedmemory.menuBarVisible = false
usedmemory.menuBar = hs.menubar.new()
usedmemory.menuTable = {
  { title = "Memory Capacity %" },
--   { title = "-" },
}
usedmemory.menuBar:setMenu(usedmemory.menuTable)

usedmemory.updateUsedMemoryMenuBar = function(usedMemoryPercent)
  if usedMemoryPercent then
    local displayStr = "💡" .. usedMemoryPercent:gsub("^%s*(.-)%s*$", "%1")
    usedmemory.menuBar:setTitle(displayStr)
  else
    usedmemory.menuBar:setTitle("")
  end
end

usedmemory.taskCallbackGetUsedMemory = function(exitCode, stdOut, stdErr)
  -- usedmemory.logger.e("taskCallbackGetUsedMemory...")
  if exitCode == 0 then
    local result = stdOut:gsub("^%s*(.-)%s*$", "%1")
    -- usedmemory.logger.e(result)
    usedmemory.updateUsedMemoryMenuBar(result)
  end
end

usedmemory.taskRunnerGetUsedMemory = function()
  if usedmemory.menuBarVisible then
    -- usedmemory.logger.e("taskRunnerGetUsedMemory...")
    usedmemory.taskGetUsedMemory = hs.task.new(os.getenv("HOME") .. "/bin/get-used-memory", usedmemory.taskCallbackGetUsedMemory)
    usedmemory.taskGetUsedMemory:start()
  end
end

usedmemory.timer = hs.timer.doEvery(5, usedmemory.taskRunnerGetUsedMemory)

usedmemory.showUsedMemoryMenuBar = function()
  usedmemory.menuBarVisible = true
  usedmemory.taskRunnerGetUsedMemory()
  usedmemory.timer:start()
end

usedmemory.hideUsedMemoryMenuBar = function()
  usedmemory.menuBarVisible = false
  usedmemory.menuBar:setTitle("")
  usedmemory.timer:stop()
end

usedmemory.toggleUsedMemoryMenuBar = function()
  if usedmemory.menuBarVisible then
    usedmemory.hideUsedMemoryMenuBar()
  else
    usedmemory.showUsedMemoryMenuBar()
  end
end

return usedmemory
