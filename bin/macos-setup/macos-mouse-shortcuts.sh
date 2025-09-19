#!/usr/bin/env bash
set -euo pipefail

set -x

for i in ~/Library/Preferences/com.apple.symbolichotkeys.plist ; do
  # READ
  # plutil -p $i
  # not sure if needed anymore in macOS Tahoe ~/Library/Containers/com.apple.Desktop-Settings.extension/Data/Library/Preferences/com.apple.symbolichotkeys.plist
  # plutil -convert json -o ./tmp_symbolichotkeys.json Library/Preferences/com.apple.symbolichotkeys.plist ; cat ./tmp_symbolichotkeys.json | jq '.AppleSymbolicHotKeys' --sort-keys ; rm ./tmp_symbolichotkeys.json

  # WRITE
  plutil -replace AppleSymbolicHotKeys -json '
{
  "118": {
    "enabled": false,
    "value": {
      "parameters": [
        65535,
        18,
        262144
      ],
      "type": "standard"
    }
  },
  "119": {
    "enabled": false,
    "value": {
      "parameters": [
        65535,
        19,
        262144
      ],
      "type": "standard"
    }
  },
  "120": {
    "enabled": false,
    "value": {
      "parameters": [
        65535,
        20,
        262144
      ],
      "type": "standard"
    }
  },
  "121": {
    "enabled": false,
    "value": {
      "parameters": [
        65535,
        21,
        262144
      ],
      "type": "standard"
    }
  },
  "163": {
    "enabled": true,
    "value": {
      "parameters": [
        96,
        50,
        1835008
      ],
      "type": "standard"
    }
  },
  "175": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        97,
        8388608
      ],
      "type": "standard"
    }
  },
  "223": {
    "enabled": false,
    "value": {
      "parameters": [
        65535,
        65535,
        0
      ],
      "type": "standard"
    }
  },
  "224": {
    "enabled": false,
    "value": {
      "parameters": [
        65535,
        65535,
        0
      ],
      "type": "standard"
    }
  },
  "36": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        118,
        8388608
      ],
      "type": "standard"
    }
  },
  "37": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        118,
        8519680
      ],
      "type": "standard"
    }
  },
  "38": {
    "enabled": true,
    "value": {
      "parameters": [
        16,
        16,
        0
      ],
      "type": "button"
    }
  },
  "40": {
    "enabled": true,
    "value": {
      "parameters": [
        16,
        16,
        131072
      ],
      "type": "button"
    }
  },
  "42": {
    "enabled": true,
    "value": {
      "parameters": [
        8,
        8,
        0
      ],
      "type": "button"
    }
  },
  "43": {
    "enabled": true,
    "value": {
      "parameters": [
        8,
        8,
        131072
      ],
      "type": "button"
    }
  },
  "53": {
    "enabled": false,
    "value": {
      "parameters": [
        65535,
        107,
        8388608
      ],
      "type": "standard"
    }
  },
  "54": {
    "enabled": false,
    "value": {
      "parameters": [
        65535,
        113,
        8388608
      ],
      "type": "standard"
    }
  },
  "56": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        113,
        8912896
      ],
      "type": "standard"
    }
  },
  "60": {
    "enabled": false,
    "value": {
      "parameters": [
        32,
        49,
        262144
      ],
      "type": "standard"
    }
  },
  "61": {
    "enabled": false,
    "value": {
      "parameters": [
        32,
        49,
        786432
      ],
      "type": "standard"
    }
  },
  "79": {
    "enabled": true,
    "value": {
      "parameters": [
        49,
        18,
        1835008
      ],
      "type": "standard"
    }
  },
  "80": {
    "enabled": true,
    "value": {
      "parameters": [
        49,
        18,
        1966080
      ],
      "type": "standard"
    }
  },
  "81": {
    "enabled": true,
    "value": {
      "parameters": [
        50,
        19,
        1835008
      ],
      "type": "standard"
    }
  },
  "82": {
    "enabled": true,
    "value": {
      "parameters": [
        50,
        19,
        1966080
      ],
      "type": "standard"
    }
  }
}' $i
done
