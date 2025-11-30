tell application "Terminal"
	set currentTab to do script ("nosleep")
	activate application "Terminal"
	do script ("exit") in currentTab
end tell
