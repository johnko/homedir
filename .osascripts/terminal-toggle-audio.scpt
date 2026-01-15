tell application "Terminal"
	set newTab to do script ("export ARG=external ; SwitchAudioSource -c | grep -i speakers || export ARG=speakers ; SwitchAudioSource -a | grep -i shokz && export ARG=shokz || true ; SwitchAudioSource -a | grep -i xm5 && export ARG=xm5 || true ; SwitchAudioSource -a | grep -i airpod && export ARG=airpod || true ; audio $ARG ; exit")
	activate
end tell
