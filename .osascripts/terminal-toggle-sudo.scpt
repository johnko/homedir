tell application "Terminal"
	activate
	tell application "System Events" to keystroke "t" using command down
	repeat while contents of selected tab of window 1 starts with linefeed
		delay 1
	end repeat
	do script ("dockprom ; export ARG=off ; grep NOPASSWD /etc/sudoers.d/50-local-user || export ARG=on ; bash ~/bin/macos-setup/macos-sudo.sh $ARG") in front window
end tell
