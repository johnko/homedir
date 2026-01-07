tell application "Terminal"
	set currentTab to do script ("SECONDS=0 ; macos-brew-update.sh ; DURATION=$SECONDS ; echo Finished in $(( DURATION/60 ))m$(( DURATION%60 ))s")
	activate application "Terminal"
end tell
