#!/usr/bin/env bash
set -euo pipefail

print_cmd(){

  while read LINE ; do
    if [[ -n "$LINE" ]] ; then
      KEY=$( echo "$LINE" | tr -d ' ' | awk -F= '{print $1}' )
      VAL=$( echo "$LINE" | tr -d ' ' | awk -F= '{print $2}' | tr -d ';' )
      if echo "$VAL" | grep -q -E '^[0-9]+$' ; then
        TYPE="-integer"
      else
        TYPE="-string"
      fi
      echo "defaults write $DOMAIN $KEY $TYPE $VAL"
    fi
  done <<EOS
$KEYVAL
EOS

}


DOMAIN='"Apple Global Domain"'
KEYVAL="
        AppleMiniaturizeOnDoubleClick = 0;
        AppleScrollerPagingBehavior = 1;
        AppleShowScrollBars = Always;
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
        NSAutomaticCapitalizationEnabled = 0;
        NSAutomaticDashSubstitutionEnabled = 0;
        NSAutomaticPeriodSubstitutionEnabled = 0;
        NSAutomaticQuoteSubstitutionEnabled = 0;
        com.apple.sound.beep.feedback = 1;
        com.apple.sound.beep.flash = 0;
        com.apple.sound.beep.volume = 1;
"
print_cmd

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
        largesize = 64;
        magnification = 1;
        mineffect = scale;
        "minimize-to-application" = 1;
        orientation = left;
        showAppExposeGestureEnabled = 0;
        tilesize = 48;
"
print_cmd

DOMAIN="com.apple.finder"
KEYVAL="
        ShowExternalHardDrivesOnDesktop = 1;
        ShowHardDrivesOnDesktop = 0;
        ShowPathbar = 1;
        ShowRecentTags = 0;
        ShowRemovableMediaOnDesktop = 1;
        ShowSidebar = 1;
        ShowStatusBar = 1;
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
