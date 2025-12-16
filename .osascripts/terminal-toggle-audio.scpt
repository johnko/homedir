tell application "Terminal"
	set currentTab to do script ("export ARG=external ; SwitchAudioSource -c | grep -i speakers || export ARG=speakers ; SwitchAudioSource -a | grep -i shokz && export ARG=shokz || true ; SwitchAudioSource -a | grep -i xm5 && export ARG=xm5 || true ; SwitchAudioSource -a | grep -i airpod && export ARG=airpod || true ; audio $ARG ; exit")
	activate application "Terminal"
end tell
