tell application "Terminal"
	set currentTab to do script ("dockprom ; export ARG=off ; grep NOPASSWD /etc/sudoers.d/50-local-user || export ARG=on ; bash ~/bin/macos-setup/macos-sudo.sh $ARG ; RPROMPT= ; PROMPT= ; date")
	activate application "Terminal"
end tell
