#!/usr/bin/env bash
set -eux

# replaces (spotlight/apps button) F4 to F4,
# (dictation button) F5 to F16,
# and eject to F13

# source: https://www.reddit.com/r/macbook/comments/x3ovje/is_there_a_way_to_adjust_keyboard_brightness_from/
# other: https://hidutil-generator.netlify.app/
# other: https://mybyways.com/blog/script-to-re-map-macbook-pro-function-keys

# fn_keys=(0 0x70000003a 0x70000003b 0x70000003c 0x70000003d 0x70000003e 0x70000003f 0x700000040 0x700000041 0x700000042 0x700000043 0x700000044 0x700000045 0x700000068 0x700000069 0x70000006a 0x70000006b 0x70000006c 0x70000006d 0x70000006e)

# fn_spotl=0xFF0100000001   # or 0xC00000221
# fn_launchp=0xFF0100000004
# f4=0x70000003D

# fn_dict=0xC000000CF
# f5=0x70000003E
# f15=0x70000006A

# fn_dnd=0x10000009B
# f6=0x70000003F
# f16=0x70000006B

# eject=0xC000000B8
# f13=0x700000068

MAPPING='
{
  "UserKeyMapping":[
    {"HIDKeyboardModifierMappingSrc": 0xFF0100000001,"HIDKeyboardModifierMappingDst": 0x70000003D},
    {"HIDKeyboardModifierMappingSrc": 0xC00000221,"HIDKeyboardModifierMappingDst": 0x70000003D},
    {"HIDKeyboardModifierMappingSrc": 0xFF0100000004,"HIDKeyboardModifierMappingDst": 0x70000003D},
    {"HIDKeyboardModifierMappingSrc": 0x70000003D,"HIDKeyboardModifierMappingDst": 0x70000003D},

    {"HIDKeyboardModifierMappingSrc": 0xC000000CF,"HIDKeyboardModifierMappingDst": 0x70000006A},
    {"HIDKeyboardModifierMappingSrc": 0x70000003E,"HIDKeyboardModifierMappingDst": 0x70000006A},

    {"HIDKeyboardModifierMappingSrc": 0x10000009B,"HIDKeyboardModifierMappingDst": 0x70000006B},
    {"HIDKeyboardModifierMappingSrc": 0x70000003F,"HIDKeyboardModifierMappingDst": 0x70000006B},

    {"HIDKeyboardModifierMappingSrc": 0xC000000B8,"HIDKeyboardModifierMappingDst": 0x700000068}
  ]
}'

/usr/bin/hidutil property --set "$(echo $MAPPING | tr -d ' ')"
