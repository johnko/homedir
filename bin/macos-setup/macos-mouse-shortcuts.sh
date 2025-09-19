#!/usr/bin/env bash
set -euo pipefail

set -x

for i in ~/Library/Preferences/com.apple.symbolichotkeys.plist ~/Library/Containers/com.apple.Desktop-Settings.extension/Data/Library/Preferences/com.apple.symbolichotkeys.plist ; do
  # READ
  # plutil -p $i
  # plutil -convert json -o ./tmp_symbolichotkeys.json Library/Preferences/com.apple.symbolichotkeys.plist ; cat ./tmp_symbolichotkeys.json | jq '.AppleSymbolicHotKeys' --sort-keys ; rm ./tmp_symbolichotkeys.json

  # WRITE
  plutil -replace AppleSymbolicHotKeys -json '
{
  "10": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        96,
        8650752
      ],
      "type": "standard"
    }
  },
  "11": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        97,
        8650752
      ],
      "type": "standard"
    }
  },
  "118": {
    "enabled": true,
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
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        19,
        262144
      ],
      "type": "standard"
    }
  },
  "12": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        122,
        8650752
      ],
      "type": "standard"
    }
  },
  "120": {
    "enabled": true,
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
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        21,
        262144
      ],
      "type": "standard"
    }
  },
  "122": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        23,
        262144
      ],
      "type": "standard"
    }
  },
  "123": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        22,
        262144
      ],
      "type": "standard"
    }
  },
  "124": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        26,
        262144
      ],
      "type": "standard"
    }
  },
  "125": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        28,
        262144
      ],
      "type": "standard"
    }
  },
  "126": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        25,
        262144
      ],
      "type": "standard"
    }
  },
  "127": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        29,
        262144
      ],
      "type": "standard"
    }
  },
  "128": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        18,
        786432
      ],
      "type": "standard"
    }
  },
  "129": {
    "enabled": 0,
    "value": {
      "parameters": [
        65535,
        19,
        786432
      ],
      "type": "standard"
    }
  },
  "13": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        98,
        8650752
      ],
      "type": "standard"
    }
  },
  "15": {
    "enabled": false,
    "value": {
      "parameters": [
        56,
        28,
        1572864
      ],
      "type": "standard"
    }
  },
  "159": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        36,
        262144
      ],
      "type": "standard"
    }
  },
  "16": {
    "enabled": 0
  },
  "162": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        96,
        9961472
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
  "164": {
    "enabled": 1,
    "value": {
      "parameters": [
        32,
        49,
        1835008
      ],
      "type": "standard"
    }
  },
  "17": {
    "enabled": false,
    "value": {
      "parameters": [
        61,
        24,
        1572864
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
  "176": {
    "enabled": 1,
    "value": {
      "parameters": [
        32,
        49,
        1966080
      ],
      "type": "SAE1.0"
    }
  },
  "179": {
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
  "18": {
    "enabled": 0
  },
  "184": {
    "enabled": true,
    "value": {
      "parameters": [
        53,
        23,
        1179648
      ],
      "type": "standard"
    }
  },
  "19": {
    "enabled": false,
    "value": {
      "parameters": [
        45,
        27,
        1572864
      ],
      "type": "standard"
    }
  },
  "190": {
    "enabled": true,
    "value": {
      "parameters": [
        113,
        12,
        8388608
      ],
      "type": "standard"
    }
  },
  "20": {
    "enabled": 0
  },
  "21": {
    "enabled": false,
    "value": {
      "parameters": [
        56,
        28,
        1835008
      ],
      "type": "standard"
    }
  },
  "215": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        65535,
        0
      ],
      "type": "standard"
    }
  },
  "216": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        65535,
        0
      ],
      "type": "standard"
    }
  },
  "217": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        65535,
        0
      ],
      "type": "standard"
    }
  },
  "218": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        65535,
        0
      ],
      "type": "standard"
    }
  },
  "219": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        65535,
        0
      ],
      "type": "standard"
    }
  },
  "22": {
    "enabled": 0
  },
  "222": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        65535,
        0
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
  "225": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        65535,
        0
      ],
      "type": "standard"
    }
  },
  "226": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        65535,
        0
      ],
      "type": "standard"
    }
  },
  "227": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        65535,
        0
      ],
      "type": "standard"
    }
  },
  "228": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        65535,
        0
      ],
      "type": "standard"
    }
  },
  "229": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        65535,
        0
      ],
      "type": "standard"
    }
  },
  "23": {
    "enabled": false,
    "value": {
      "parameters": [
        92,
        65535,
        1572864
      ],
      "type": "standard"
    }
  },
  "230": {
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
  "231": {
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
  "232": {
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
  "233": {
    "enabled": true,
    "value": {
      "parameters": [
        109,
        46,
        1048576
      ],
      "type": "standard"
    }
  },
  "235": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        65535,
        0
      ],
      "type": "standard"
    }
  },
  "237": {
    "enabled": true,
    "value": {
      "parameters": [
        102,
        3,
        8650752
      ],
      "type": "standard"
    }
  },
  "238": {
    "enabled": true,
    "value": {
      "parameters": [
        99,
        8,
        8650752
      ],
      "type": "standard"
    }
  },
  "239": {
    "enabled": true,
    "value": {
      "parameters": [
        114,
        15,
        8650752
      ],
      "type": "standard"
    }
  },
  "24": {
    "enabled": 0
  },
  "240": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        123,
        8650752
      ],
      "type": "standard"
    }
  },
  "241": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        124,
        8650752
      ],
      "type": "standard"
    }
  },
  "242": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        126,
        8650752
      ],
      "type": "standard"
    }
  },
  "243": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        125,
        8650752
      ],
      "type": "standard"
    }
  },
  "244": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        65535,
        0
      ],
      "type": "standard"
    }
  },
  "245": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        65535,
        0
      ],
      "type": "standard"
    }
  },
  "246": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        65535,
        0
      ],
      "type": "standard"
    }
  },
  "247": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        65535,
        0
      ],
      "type": "standard"
    }
  },
  "248": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        123,
        8781824
      ],
      "type": "standard"
    }
  },
  "249": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        124,
        8781824
      ],
      "type": "standard"
    }
  },
  "25": {
    "enabled": false,
    "value": {
      "parameters": [
        46,
        47,
        1835008
      ],
      "type": "standard"
    }
  },
  "250": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        126,
        8781824
      ],
      "type": "standard"
    }
  },
  "251": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        125,
        8781824
      ],
      "type": "standard"
    }
  },
  "256": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        65535,
        0
      ],
      "type": "standard"
    }
  },
  "257": {
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
  "258": {
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
  "26": {
    "enabled": false,
    "value": {
      "parameters": [
        44,
        43,
        1835008
      ],
      "type": "standard"
    }
  },
  "260": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        53,
        1048576
      ],
      "type": "standard"
    }
  },
  "27": {
    "enabled": true,
    "value": {
      "parameters": [
        96,
        50,
        1048576
      ],
      "type": "standard"
    }
  },
  "28": {
    "enabled": true,
    "value": {
      "parameters": [
        51,
        20,
        1179648
      ],
      "type": "standard"
    }
  },
  "29": {
    "enabled": true,
    "value": {
      "parameters": [
        51,
        20,
        1441792
      ],
      "type": "standard"
    }
  },
  "30": {
    "enabled": true,
    "value": {
      "parameters": [
        52,
        21,
        1179648
      ],
      "type": "standard"
    }
  },
  "31": {
    "enabled": true,
    "value": {
      "parameters": [
        52,
        21,
        1441792
      ],
      "type": "standard"
    }
  },
  "32": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        126,
        8650752
      ],
      "type": "standard"
    }
  },
  "33": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        125,
        8650752
      ],
      "type": "standard"
    }
  },
  "34": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        126,
        8781824
      ],
      "type": "standard"
    }
  },
  "35": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        125,
        8781824
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
        8,
        8,
        0
      ],
      "type": "button"
    }
  },
  "39": {
    "enabled": 0
  },
  "40": {
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
  "41": {
    "enabled": 0
  },
  "42": {
    "enabled": 1,
    "value": {
      "parameters": [
        16,
        16,
        0
      ],
      "type": "button"
    }
  },
  "43": {
    "enabled": 1,
    "value": {
      "parameters": [
        16,
        16,
        131072
      ],
      "type": "button"
    }
  },
  "44": {
    "enabled": 0
  },
  "45": {
    "enabled": 0
  },
  "46": {
    "enabled": 0
  },
  "48": {
    "enabled": 0
  },
  "49": {
    "enabled": 0
  },
  "52": {
    "enabled": true,
    "value": {
      "parameters": [
        100,
        2,
        1572864
      ],
      "type": "standard"
    }
  },
  "53": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        107,
        8388608
      ],
      "type": "standard"
    }
  },
  "55": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        107,
        8912896
      ],
      "type": "standard"
    }
  },
  "57": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        100,
        8650752
      ],
      "type": "standard"
    }
  },
  "59": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        96,
        9437184
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
  "7": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        120,
        8650752
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
  "8": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        99,
        8650752
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
  },
  "9": {
    "enabled": true,
    "value": {
      "parameters": [
        65535,
        118,
        8650752
      ],
      "type": "standard"
    }
  },
  "98": {
    "enabled": 1,
    "value": {
      "parameters": [
        47,
        44,
        1179648
      ],
      "type": "standard"
    }
  }
}' $i
done
