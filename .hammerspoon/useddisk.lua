local useddisk = {}
useddisk.logger = hs.logger.new("useddisk")
useddisk.menuBarVisible = false
useddisk.menuBar = hs.menubar.new()
useddisk.menuTable = {
  { title = "Disk Capacity %" },
--   { title = "-" },
}
useddisk.menuBar:setMenu(useddisk.menuTable)

useddisk.updateUsedDiskMenuBar = function(usedDiskPercent)
  if usedDiskPercent then
    local displayStr = "💾" .. usedDiskPercent:gsub("^%s*(.-)%s*$", "%1")
    useddisk.menuBar:setTitle(displayStr)
  else
    useddisk.menuBar:setTitle("")
  end
end

useddisk.taskCallbackGetUsedDisk = function(exitCode, stdOut, stdErr)
  -- useddisk.logger.e("taskCallbackGetUsedDisk...")
  if exitCode == 0 then
    local result = stdOut:gsub("^%s*(.-)%s*$", "%1")
    -- useddisk.logger.e(result)
    useddisk.updateUsedDiskMenuBar(result)
  end
end

useddisk.taskRunnerGetUsedDisk = function()
  if useddisk.menuBarVisible then
    -- useddisk.logger.e("taskRunnerGetUsedDisk...")
    useddisk.taskGetUsedDisk = hs.task.new(os.getenv("HOME") .. "/bin/get-used-disk", useddisk.taskCallbackGetUsedDisk)
    useddisk.taskGetUsedDisk:start()
  end
end

useddisk.timer = hs.timer.doEvery(30, useddisk.taskRunnerGetUsedDisk)

useddisk.showUsedDiskMenuBar = function()
  useddisk.menuBarVisible = true
  useddisk.taskRunnerGetUsedDisk()
  useddisk.timer:start()
end

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
