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
        tilesize = 32;
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

# https://apple.stackexchange.com/questions/87619/where-are-keyboard-shortcuts-stored-for-backup-and-sync-purposes
# printf "defaults write NSGlobalDomain NSUserKeyEquivalents '$(defaults read NSGlobalDomain NSUserKeyEquivalents)'"
cat <<EOS
defaults write NSGlobalDomain NSUserKeyEquivalents '{
    "Emoji & Symbols" = "\Uf714";
    "Enter Full Screen" = "@^f";
    "Exit Full Screen" = "@^f";
    "Secure Keyboard Entry" = "@~^\Uf714";
    "Toggle Full Screen" = "@^f";
}'
EOS

echo "killall Dock"
