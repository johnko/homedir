-- Open in Apple "Script Editor"
-- Save as "Application"
-- Tick "Stay open after run handler"
-- "Run Application"

on run
	display notification "Started" with title "yabai"
	do shell script "export PATH=$HOME/bin && yabai"
end run

on quit
	display notification "Stopped" with title "yabai"
	do shell script "pkill yabai"
end quit
