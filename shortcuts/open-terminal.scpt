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
tell application "Terminal"
	activate
end tell
tell application "System Events"
	set visible of application process "Terminal" to true
	set frontApp to first application process whose frontmost is true
	set frontAppName to name of frontApp
	tell process frontAppName
		try
			tell (1st window whose value of attribute "AXMain" is true)
				set windowTitle to value of attribute "AXTitle"
			end tell
		on error errMsg
			if frontAppName is "Terminal" then
				tell application "System Events" to tell process "Terminal"
					click menu item 1 of its menu of menu item "New Window" of its menu of menu bar item "Shell" of menu bar 1
				end tell
			end if
		end try
	end tell
end tell
set actionTaken to "visible: " & frontAppName
return actionTaken
