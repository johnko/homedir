#!/usr/bin/env bash
set -eu

print_cmd(){

  while read LINE ; do
    if [[ -n "$LINE" ]]; then
      KEY=$( echo "$LINE" | tr -d ' ' | awk -F= '{print $1}' )
      VAL=$( echo "$LINE" | tr -d ' ' | awk -F= '{print $2}' | tr -d ';' )
      if echo "$VAL" | grep -q -E '^[0-9]+$' ; then
        TYPE="-integer"
      else
        TYPE="-string"
      fi
      echo "defaults write $DOMAIN $KEY $TYPE $VAL"
    fi
  done <<EOF
$KEYVAL
EOF

}


DOMAIN="com.apple.WindowManager"
KEYVAL="
        AppWindowGroupingBehavior = 0;
        AutoHide = 0;
        EnableTiledWindowMargins = 0;
        EnableTilingByEdgeDrag = 0;
        EnableTilingOptionAccelerator = 1;
        EnableTopTilingByEdgeDrag = 0;
        HideDesktop = 1;
        StageManagerHideWidgets = 0;
        StandardHideDesktopIcons = 1;
        StandardHideWidgets = 0;
"
print_cmd

DOMAIN="com.apple.dock"
KEYVAL="
        enterMissionControlByTopWindowDrag = 0;
        mineffect = scale;
        tilesize = 64;
"
print_cmd

DOMAIN="com.apple.finder"
KEYVAL="
        ShowExternalHardDrivesOnDesktop = 1;
        ShowHardDrivesOnDesktop = 0;
        ShowRemovableMediaOnDesktop = 1;
"
print_cmd

DOMAIN="com.apple.menuextra.clock"
KEYVAL="
        FlashDateSeparators = 1;
        ShowDate = 0;
        ShowDayOfWeek = 1;
"
print_cmd

echo "killall Dock"
