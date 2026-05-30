tell application "Terminal"
	set newTab to do script ("cd ; macos-vscode-config-fix.sh ; dockprom start ; if [[ -e code/cursor/lab/router-node-exporter ]]; then cd code/cursor/lab/router-node-exporter ; bash deploy.sh ; fi ; cd ; export ARG=off ; grep NOPASSWD /etc/sudoers.d/50-local-user || export ARG=on ; bash ~/bin/macos-setup/macos-sudo.sh $ARG")
	activate
end tell
