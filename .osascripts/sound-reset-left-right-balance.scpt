-- https://www.reddit.com/r/apple/comments/34qmn0/is_there_a_shortcut_or_command_to_switch_the_lr/
-- https://www.macscripter.net/t/changing-sound-input-output-system-preferences-system-settings/74356
-- https://www.macscripter.net/t/i-can-get-the-sound-balance-but-cant-set-it-ventura/74629/2

tell application "System Settings"
  activate
end tell
tell application "System Events"
  tell application process "System Settings"
    -- wait/check for 5 seconds
    repeat with i from 10 to 0 by -1
      if exists window 1 then exit repeat
      delay 0.2
    end repeat
    -- timed-out
    if i = 0 then return
    set soundPane to row 1 of outline 1 of scroll area 1 of group 1 of splitter group 1 of group 1 of window 1 whose value of the first static text of UI element 1 is "Sound"
    if not (selected of soundPane) then set selected of soundPane to true
    -- wait/check for 5 seconds
    repeat with i from 25 to 0 by -1
      try
        window "Sound"
        exit repeat
      end try
      delay 0.5
    end repeat
    -- timed-out
    if i = 0 then return
    -- Select output tab
    set myButton to (first radio button of tab group 1 of group 2 of scroll area 1 of group 1 of group 2 of splitter group 1 of group 1 of window "Sound" whose description is "Output")
    if value of myButton = 0 then
      perform action "AXPress" of item 1 of myButton
    end if
    -- reset balance to middle
    tell its window "Sound"
      tell slider "Balance" of group 3 of scroll area 1 of group 1 of group 2 of splitter group 1 of group 1
        repeat while value > 0.0
          perform action "AXDecrement"
        end repeat
        repeat while value < 0.49
          perform action "AXIncrement"
        end repeat
      end tell
    end tell
  end tell
end tell
