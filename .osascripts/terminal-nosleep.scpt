tell application "Terminal"
	activate
	tell application "System Events" to keystroke "t" using command down
	repeat while contents of selected tab of window 1 starts with linefeed
		delay 1
	end repeat
	do script ("nosleep ; exit") in front window
end tell
