tell application "Terminal"
	set currentTab to do script ("export ARG=off ; grep NOPASSWD /etc/sudoers.d/50-local-user || export ARG=on ; bash ~/bin/macos-setup/macos-sudo.sh $ARG")
	activate application "Terminal"
	do script ("exit") in currentTab
end tell
