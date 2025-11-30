tell application "Terminal"
	set currentTab to do script ("export ARG=external ; SwitchAudioSource -c | grep -i speakers || export ARG=speakers")
	activate application "Terminal"
	do script ("SwitchAudioSource -a | grep -i shokz && export ARG=shokz || true") in currentTab
	do script ("SwitchAudioSource -a | grep -i xm5 && export ARG=xm5 || true") in currentTab
	do script ("SwitchAudioSource -a | grep -i airpod && export ARG=airpod || true") in currentTab
	do script ("audio $ARG") in currentTab
	do script ("exit") in currentTab
end tell
