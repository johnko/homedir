-- original: https://stackoverflow.com/questions/17964660/how-to-detect-if-user-is-away-in-os-x

-- Open in Apple "Script Editor"
-- Save as "Application"
-- Tick "Stay open after run handler"
-- "Run Application"

global timeBeforeComputerIsNotInUse, computerIsInUse, previousIdleTime

on run
	set timeBeforeComputerIsNotInUse to 50 -- seconds
	set computerIsInUse to true
	set previousIdleTime to 0
	display notification "Started" with title "macos-detect-idle"
	say "Started"
end run

on idle
	set idleTime to (do shell script "ioreg -c IOHIDSystem | awk '/HIDIdleTime/ {print $NF/1000000000; exit}'") as number

	if not computerIsInUse then
		if idleTime is less than previousIdleTime then
			set computerIsInUse to true
			display notification "User is using the computer again" with title "macos-detect-idle"
		end if
	else if idleTime is greater than or equal to timeBeforeComputerIsNotInUse then
		set computerIsInUse to false
		display notification "User has left the computer" with title "macos-detect-idle"
		say "Ten"
	end if

	set previousIdleTime to idleTime
	return 1
end idle
