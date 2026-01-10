tell application "Terminal"
	activate
	tell application "System Events" to keystroke "t" using command down
	repeat while contents of selected tab of window 1 starts with linefeed
		delay 1
	end repeat
	do script ("SECONDS=0 ; macos-brew-prune.sh ; DURATION=$SECONDS ; echo Finished in $(( DURATION/60 ))m$(( DURATION%60 ))s") in front window
end tell
