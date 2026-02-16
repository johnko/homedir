#!/usr/bin/env bash
set -euo pipefail

print_cmd() {

  while read -r LINE; do
    if [[ -n $LINE ]]; then
      KEY=$(echo "$LINE" | tr -d ' ' | awk -F= '{print $1}')
      VAL=$(echo "$LINE" | tr -d ' ' | awk -F= '{print $2}' | tr -d ';')
      if echo "$VAL" | grep -q -E '^[0-9]+$'; then
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
        AppleInterfaceStyle = Dark;
        AppleMenuBarVisibleInFullscreen = 1;
        AppleMiniaturizeOnDoubleClick = 0;
        AppleReduceDesktopTinting = 0;
        AppleScrollerPagingBehavior = 1;
        AppleShowAllExtensions = 1;
        AppleShowScrollBars = Always;
        AppleSpacesSwitchOnActivate = 0;
        InitialKeyRepeat = 30;
        KeyRepeat = 2;
        NSAutomaticCapitalizationEnabled = 0;
        NSAutomaticDashSubstitutionEnabled = 0;
        NSAutomaticInlinePredictionEnabled = 1;
        NSAutomaticPeriodSubstitutionEnabled = 0;
        NSAutomaticQuoteSubstitutionEnabled = 0;
        NSAutomaticSpellingCorrectionEnabled = 0;
        NSGlassDiffusionSetting = 1;
        NSSmartReplyEnabled = 0;
        WebAutomaticSpellingCorrectionEnabled = 0;
        com.apple.sound.beep.feedback = 1;
        com.apple.sound.beep.flash = 0;
        com.apple.sound.beep.volume = 1;
"
print_cmd

DOMAIN="com.apple.WindowManager"
# GloballyEnabled = StageManager
KEYVAL="
        AppWindowGroupingBehavior = 0;
        AutoHide = 0;
        EnableTiledWindowMargins = 0;
        EnableTilingByEdgeDrag = 0;
        EnableTilingOptionAccelerator = 0;
        EnableTopTilingByEdgeDrag = 0;
        GloballyEnabled = 1;
        GloballyEnabledEver = 1;
        HideDesktop = 1;
        StageManagerHideWidgets = 0;
        StandardHideDesktopIcons = 1;
        StandardHideWidgets = 0;
"
print_cmd

DOMAIN="com.apple.dock"
KEYVAL='
        enterMissionControlByTopWindowDrag = 0;
        "expose-group-apps" = 0;
        largesize = 64;
        launchanim = 0;
        magnification = 1;
        mineffect = scale;
        "minimize-to-application" = 0;
        "mru-spaces" = 0;
        orientation = left;
        showAppExposeGestureEnabled = 0;
        showMissionControlGestureEnabled = 1;
        tilesize = 48;
'
print_cmd

DOMAIN="com.apple.finder"
KEYVAL="
        FinderSpawnTab = 0;
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
        IsAnalog = 0;
        ShowAMPM = 1;
        ShowDate = 0;
        ShowDayOfWeek = 1;
        ShowSeconds = 0;
        TimeAnnouncementsEnabled = 0;
"
print_cmd

echo "killall Dock"
