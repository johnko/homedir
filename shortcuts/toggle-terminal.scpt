global frontApp, frontAppName, windowTitle
set windowTitle to ""
tell application "System Events"
	set frontApp to first application process whose frontmost is true
	set frontAppName to name of frontApp
	tell process frontAppName
		tell (1st window whose value of attribute "AXMain" is true)
			set windowTitle to value of attribute "AXTitle"
		end tell
	end tell
end tell

set actionTaken to ""
if frontAppName is "Terminal" then
	tell application "System Events"
		set visible of application process "Terminal" to false
	end tell
	set actionTaken to "Terminal hidden"
else
	tell application "System Events"
		set visible of application process "Terminal" to true
	end tell
	tell application "Terminal"
		activate
	end tell
	set actionTaken to "Terminal visible"
end if
return actionTaken
