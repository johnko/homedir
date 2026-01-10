tell application "Terminal"
	activate
	tell application "System Events" to keystroke "t" using command down
	repeat while contents of selected tab of window 1 starts with linefeed
		delay 1
	end repeat
	do script ("export ARG=external ; SwitchAudioSource -c | grep -i speakers || export ARG=speakers ; SwitchAudioSource -a | grep -i shokz && export ARG=shokz || true ; SwitchAudioSource -a | grep -i xm5 && export ARG=xm5 || true ; SwitchAudioSource -a | grep -i airpod && export ARG=airpod || true ; audio $ARG ; exit") in front window
end tell
