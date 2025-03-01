-- https://gist.github.com/timpulver/4753750

global frontApp, frontAppName, windowTitle
set windowTitle to ""
tell application "System Events"
	set frontApp to first application process whose frontmost is true
	set frontAppName to name of frontApp
	tell process frontAppName
		try
			tell (1st window whose value of attribute "AXMain" is true)
				set windowTitle to value of attribute "AXTitle"
			end tell
		on error errMsg
		end try
	end tell
end tell

set actionTaken to ""
tell application "System Events"
	set visible of application process frontAppName to false
end tell
set actionTaken to "visible: " & frontAppName
return actionTaken
