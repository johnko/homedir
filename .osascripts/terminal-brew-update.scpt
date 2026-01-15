tell application "Terminal"
	set newTab to do script ("SECONDS=0 ; macos-brew-update.sh ; DURATION=$SECONDS ; echo Finished in $(( DURATION/60 ))m$(( DURATION%60 ))s")
	activate
end tell
