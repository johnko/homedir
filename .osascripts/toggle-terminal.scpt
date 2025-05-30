-- https://gist.github.com/timpulver/4753750

set appNameToToggle to "Terminal"

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
if frontAppName is appNameToToggle then
	tell application "System Events"
		set visible of application process appNameToToggle to false
	end tell
	set actionTaken to "hidden: " & frontAppName
else
	tell application appNameToToggle
		activate
	end tell
	tell application "System Events"
		set visible of application process appNameToToggle to true
		set frontApp to first application process whose frontmost is true
		set frontAppName to name of frontApp
		tell process frontAppName
			try
				tell (1st window whose value of attribute "AXMain" is true)
					set windowTitle to value of attribute "AXTitle"
				end tell
			on error errMsg
				if frontAppName is appNameToToggle then
					tell application "System Events" to tell process appNameToToggle
						click menu item 1 of its menu of menu item "New Window" of its menu of menu bar item "Shell" of menu bar 1
					end tell
				end if
			end try
		end tell
	end tell
	set actionTaken to "visible: " & frontAppName
end if

return actionTaken
