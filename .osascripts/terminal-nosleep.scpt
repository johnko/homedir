tell application "Terminal"
	set currentTab to do script ("SECONDS=0")
	activate application "Terminal"
	-- delay 1
	do script ("nosleep") in currentTab
	do script ("exit") in currentTab
end tell
