tell application "Terminal"
	set currentTab to do script ("macos-brew-prune.sh")
	activate application "Terminal"
	delay 2
	do script ("date -j ; echo Done") in currentTab
end tell
