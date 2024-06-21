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
tell application "Terminal"
	activate
	-- set the bounds of window 1 to {0, 2828, 2160, 3742}
	set the bounds of window 1 to {0, 0, 2160, 914}
end tell


tell application "Google Chrome"
	activate
	-- set the bounds of window 1 to {0, 0, 2160, 2802}
	set the bounds of window 1 to {0, 940, 2160, 3742}
end tell


#tell application "System Events" to tell process "Google Chrome"
#  click menu item "Move Window to Left Side of Screen" of menu "Window" of menu bar 1
#end tell
