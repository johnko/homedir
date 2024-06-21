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
