tell application "Terminal"
	set currentTab to do script ("macos-brew-update.sh")
	activate application "Terminal"
	delay 2
	do script ("date -j ; echo Done") in currentTab
end tell
