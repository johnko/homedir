tell application "Terminal"
	set newTab to do script ("dockprom ; macos-vscode-config-fix.sh ; export ARG=off ; grep NOPASSWD /etc/sudoers.d/50-local-user || export ARG=on ; bash ~/bin/macos-setup/macos-sudo.sh $ARG")
	activate
end tell
