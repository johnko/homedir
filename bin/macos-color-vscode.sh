#!/usr/bin/env bash
set -euo pipefail

# set -x

if [ -e "$HOME/Library/Application Support/Code/User/settings.json" ]; then

  set +u
  COLOR=$1
  if [ -z "$COLOR" ]; then
    cat <<EOF
Usage: $0 <color>

Where <color> is one of:
  - black
  - white
  - silver
  - red
  - green
  - yellow
  - blue
  - purple
  - magenta
  - orange
  - cyan
EOF
    exit 1
  fi
  set -u

  case "$COLOR" in
    black)
      JSON_STRING='
{
  "workbench.colorCustomizations": {
    "activityBar.activeBackground": "#3b3b3b",
    "activityBar.background": "#3b3b3b",
    "activityBar.foreground": "#e7e7e7",
    "activityBar.inactiveForeground": "#e7e7e799",
    "activityBarBadge.background": "#787828",
    "activityBarBadge.foreground": "#e7e7e7",
    "commandCenter.border": "#e7e7e799",
    "sash.hoverBorder": "#3b3b3b",
    "statusBar.background": "#222222",
    "statusBar.foreground": "#e7e7e7",
    "statusBarItem.hoverBackground": "#3b3b3b",
    "statusBarItem.remoteBackground": "#222222",
    "statusBarItem.remoteForeground": "#e7e7e7",
    "titleBar.activeBackground": "#222222",
    "titleBar.activeForeground": "#e7e7e7",
    "titleBar.inactiveBackground": "#22222299",
    "titleBar.inactiveForeground": "#e7e7e799"
  },
  "peacock.color": "#222222"
}
'
      ;;
    white)
      JSON_STRING='
{
  "workbench.colorCustomizations": {
    "activityBar.activeBackground": "#ffffff",
    "activityBar.background": "#ffffff",
    "activityBar.foreground": "#15202b",
    "activityBar.inactiveForeground": "#15202b99",
    "activityBarBadge.background": "#df9f9f",
    "activityBarBadge.foreground": "#15202b",
    "commandCenter.border": "#15202b99",
    "sash.hoverBorder": "#ffffff",
    "statusBar.background": "#eeeeee",
    "statusBar.foreground": "#15202b",
    "statusBarItem.hoverBackground": "#d4d4d4",
    "statusBarItem.remoteBackground": "#eeeeee",
    "statusBarItem.remoteForeground": "#15202b",
    "titleBar.activeBackground": "#eeeeee",
    "titleBar.activeForeground": "#15202b",
    "titleBar.inactiveBackground": "#eeeeee99",
    "titleBar.inactiveForeground": "#15202b99"
  },
  "peacock.color": "#eeeeee"
}
'
      ;;
    silver | grey | gray)
      JSON_STRING='
{
  "workbench.colorCustomizations": {
    "activityBar.activeBackground": "#999999",
    "activityBar.background": "#999999",
    "activityBar.foreground": "#15202b",
    "activityBar.inactiveForeground": "#15202b99",
    "activityBarBadge.background": "#5858c7",
    "activityBarBadge.foreground": "#e7e7e7",
    "commandCenter.border": "#15202b99",
    "sash.hoverBorder": "#999999",
    "statusBar.background": "#808080",
    "statusBar.foreground": "#15202b",
    "statusBarItem.hoverBackground": "#666666",
    "statusBarItem.remoteBackground": "#808080",
    "statusBarItem.remoteForeground": "#15202b",
    "titleBar.activeBackground": "#808080",
    "titleBar.activeForeground": "#15202b",
    "titleBar.inactiveBackground": "#80808099",
    "titleBar.inactiveForeground": "#15202b99"
  },
  "peacock.color": "gray"
}
'
      ;;
    red)
      JSON_STRING='
{
  "workbench.colorCustomizations": {
    "activityBar.activeBackground": "#ff0000",
    "activityBar.background": "#ff0000",
    "activityBar.foreground": "#e7e7e7",
    "activityBar.inactiveForeground": "#e7e7e799",
    "activityBarBadge.background": "#00df00",
    "activityBarBadge.foreground": "#15202b",
    "commandCenter.border": "#e7e7e799",
    "sash.hoverBorder": "#ff0000",
    "statusBar.background": "#cc0000",
    "statusBar.foreground": "#e7e7e7",
    "statusBarItem.hoverBackground": "#ff0000",
    "statusBarItem.remoteBackground": "#cc0000",
    "statusBarItem.remoteForeground": "#e7e7e7",
    "titleBar.activeBackground": "#cc0000",
    "titleBar.activeForeground": "#e7e7e7",
    "titleBar.inactiveBackground": "#cc000099",
    "titleBar.inactiveForeground": "#e7e7e799"
  },
  "peacock.color": "#cc0000"
}
'
      ;;
    green)
      JSON_STRING='
{
  "workbench.colorCustomizations": {
    "activityBar.activeBackground": "#00b300",
    "activityBar.background": "#00b300",
    "activityBar.foreground": "#e7e7e7",
    "activityBar.inactiveForeground": "#e7e7e799",
    "activityBarBadge.background": "#dfdfff",
    "activityBarBadge.foreground": "#15202b",
    "commandCenter.border": "#e7e7e799",
    "sash.hoverBorder": "#00b300",
    "statusBar.background": "#008000",
    "statusBar.foreground": "#e7e7e7",
    "statusBarItem.hoverBackground": "#00b300",
    "statusBarItem.remoteBackground": "#008000",
    "statusBarItem.remoteForeground": "#e7e7e7",
    "titleBar.activeBackground": "#008000",
    "titleBar.activeForeground": "#e7e7e7",
    "titleBar.inactiveBackground": "#00800099",
    "titleBar.inactiveForeground": "#e7e7e799"
  },
  "peacock.color": "green"
}
'
      ;;
    yellow)
      JSON_STRING='
{
  "workbench.colorCustomizations": {
    "activityBar.activeBackground": "#ffff33",
    "activityBar.background": "#ffff33",
    "activityBar.foreground": "#15202b",
    "activityBar.inactiveForeground": "#15202b99",
    "activityBarBadge.background": "#00bfbf",
    "activityBarBadge.foreground": "#15202b",
    "commandCenter.border": "#15202b99",
    "sash.hoverBorder": "#ffff33",
    "statusBar.background": "#ffff00",
    "statusBar.foreground": "#15202b",
    "statusBarItem.hoverBackground": "#cccc00",
    "statusBarItem.remoteBackground": "#ffff00",
    "statusBarItem.remoteForeground": "#15202b",
    "titleBar.activeBackground": "#ffff00",
    "titleBar.activeForeground": "#15202b",
    "titleBar.inactiveBackground": "#ffff0099",
    "titleBar.inactiveForeground": "#15202b99"
  },
  "peacock.color": "yellow"
}
'
      ;;
    blue)
      JSON_STRING='
{
  "workbench.colorCustomizations": {
    "activityBar.activeBackground": "#3366ff",
    "activityBar.background": "#3366ff",
    "activityBar.foreground": "#e7e7e7",
    "activityBar.inactiveForeground": "#e7e7e799",
    "activityBarBadge.background": "#800020",
    "activityBarBadge.foreground": "#e7e7e7",
    "commandCenter.border": "#e7e7e799",
    "sash.hoverBorder": "#3366ff",
    "statusBar.background": "#0040ff",
    "statusBar.foreground": "#e7e7e7",
    "statusBarItem.hoverBackground": "#3366ff",
    "statusBarItem.remoteBackground": "#0040ff",
    "statusBarItem.remoteForeground": "#e7e7e7",
    "titleBar.activeBackground": "#0040ff",
    "titleBar.activeForeground": "#e7e7e7",
    "titleBar.inactiveBackground": "#0040ff99",
    "titleBar.inactiveForeground": "#e7e7e799"
  },
  "peacock.color": "#0040ff"
}
'
      ;;
    purple)
      JSON_STRING='
{
  "workbench.colorCustomizations": {
    "activityBar.activeBackground": "#a56bee",
    "activityBar.background": "#a56bee",
    "activityBar.foreground": "#15202b",
    "activityBar.inactiveForeground": "#15202b99",
    "activityBarBadge.background": "#f2b98d",
    "activityBarBadge.foreground": "#15202b",
    "commandCenter.border": "#e7e7e799",
    "sash.hoverBorder": "#a56bee",
    "statusBar.background": "#893de9",
    "statusBar.foreground": "#e7e7e7",
    "statusBarItem.hoverBackground": "#a56bee",
    "statusBarItem.remoteBackground": "#893de9",
    "statusBarItem.remoteForeground": "#e7e7e7",
    "titleBar.activeBackground": "#893de9",
    "titleBar.activeForeground": "#e7e7e7",
    "titleBar.inactiveBackground": "#893de999",
    "titleBar.inactiveForeground": "#e7e7e799"
  },
  "peacock.color": "#893de9"
}
'
      ;;
    magenta)
      JSON_STRING='
{
  "workbench.colorCustomizations": {
    "activityBar.activeBackground": "#ff33ff",
    "activityBar.background": "#ff33ff",
    "activityBar.foreground": "#15202b",
    "activityBar.inactiveForeground": "#15202b99",
    "activityBarBadge.background": "#dfdf00",
    "activityBarBadge.foreground": "#15202b",
    "commandCenter.border": "#e7e7e799",
    "sash.hoverBorder": "#ff33ff",
    "statusBar.background": "#ff00ff",
    "statusBar.foreground": "#e7e7e7",
    "statusBarItem.hoverBackground": "#ff33ff",
    "statusBarItem.remoteBackground": "#ff00ff",
    "statusBarItem.remoteForeground": "#e7e7e7",
    "titleBar.activeBackground": "#ff00ff",
    "titleBar.activeForeground": "#e7e7e7",
    "titleBar.inactiveBackground": "#ff00ff99",
    "titleBar.inactiveForeground": "#e7e7e799"
  },
  "peacock.color": "#ff00ff"
}
'
      ;;
    orange)
      JSON_STRING='
{
  "workbench.colorCustomizations": {
    "activityBar.activeBackground": "#ff9933",
    "activityBar.background": "#ff9933",
    "activityBar.foreground": "#15202b",
    "activityBar.inactiveForeground": "#15202b99",
    "activityBarBadge.background": "#008040",
    "activityBarBadge.foreground": "#e7e7e7",
    "commandCenter.border": "#15202b99",
    "sash.hoverBorder": "#ff9933",
    "statusBar.background": "#ff8000",
    "statusBar.foreground": "#15202b",
    "statusBarItem.hoverBackground": "#cc6600",
    "statusBarItem.remoteBackground": "#ff8000",
    "statusBarItem.remoteForeground": "#15202b",
    "titleBar.activeBackground": "#ff8000",
    "titleBar.activeForeground": "#15202b",
    "titleBar.inactiveBackground": "#ff800099",
    "titleBar.inactiveForeground": "#15202b99"
  },
  "peacock.color": "#ff8000"
}
'
      ;;
    cyan)
      JSON_STRING='
{
  "workbench.colorCustomizations": {
    "activityBar.activeBackground": "#33ffff",
    "activityBar.background": "#33ffff",
    "activityBar.foreground": "#15202b",
    "activityBar.inactiveForeground": "#15202b99",
    "activityBarBadge.background": "#ff60ff",
    "activityBarBadge.foreground": "#15202b",
    "commandCenter.border": "#15202b99",
    "sash.hoverBorder": "#33ffff",
    "statusBar.background": "#00ffff",
    "statusBar.foreground": "#15202b",
    "statusBarItem.hoverBackground": "#00cccc",
    "statusBarItem.remoteBackground": "#00ffff",
    "statusBarItem.remoteForeground": "#15202b",
    "titleBar.activeBackground": "#00ffff",
    "titleBar.activeForeground": "#15202b",
    "titleBar.inactiveBackground": "#00ffff99",
    "titleBar.inactiveForeground": "#15202b99"
  },
  "peacock.color": "cyan"
}
'
      ;;
    test)
      for i in $(macos-color-vscode.sh | grep -- ' - ' | awk '{print $NF}'); do
        macos-color-vscode.sh "$i"
        echo "Tested $i ... Press ENTER to contine."
        read -r
      done
      exit 1
      ;;
    *)
      echo "❌ Invalid color: $COLOR"
      exit 1
      ;;
  esac

  mkdir -p .vscode

  if [[ ! -e .vscode/settings.json ]] || ! jq '.' .vscode/settings.json; then
    echo "Generating new .vscode/settings.json"
    jq --argjson str "$JSON_STRING" '. + $str' --sort-keys >.vscode/settings.json
  else
    cat .vscode/settings.json |
      jq --argjson str "$JSON_STRING" '. + $str' --sort-keys >.vscode/settings2.json
    cat .vscode/settings2.json >.vscode/settings.json
  fi

  echo "✅ Color set to: $COLOR"

fi
