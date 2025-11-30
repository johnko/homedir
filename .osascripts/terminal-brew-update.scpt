tell application "Terminal"
	set currentTab to do script ("SECONDS=0")
	activate application "Terminal"
	delay 1
	do script ("macos-brew-update.sh") in currentTab
	do script ("DURATION=$SECONDS ; echo Finished in $(( DURATION/60 ))m$(( DURATION%60 ))s") in currentTab
	do script ("exit") in currentTab
end tell
