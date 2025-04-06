#!/usr/bin/env bash
set -euo pipefail

set -x

# replaces (dictation button) F5 and (focus button) F6 with keyboard brightness and eject to play/pause

# source: https://www.reddit.com/r/macbook/comments/x3ovje/is_there_a_way_to_adjust_keyboard_brightness_from/
# other: https://hidutil-generator.netlify.app/
# other: https://mybyways.com/blog/script-to-re-map-macbook-pro-function-keys

# fn_keys=(0 0x70000003a 0x70000003b 0x70000003c 0x70000003d 0x70000003e 0x70000003f 0x700000040 0x700000041 0x700000042 0x700000043 0x700000044 0x700000045 0x700000068 0x700000069 0x70000006a 0x70000006b 0x70000006c 0x70000006d 0x70000006e)

# fn_dict=0xC000000CF
# f5=0x70000003E
# fn_kbd_dec=0xFF00000009

# fn_dnd=0x10000009B
# f6=0x70000003F
# fn_kbd_inc=0xFF00000008

# eject=0xC000000B8
# fn_play=0xC000000CD

MAPPING='
{
  "UserKeyMapping":[
    {"HIDKeyboardModifierMappingSrc": 0xC000000CF,"HIDKeyboardModifierMappingDst": 0xFF00000009},
    {"HIDKeyboardModifierMappingSrc": 0x70000003E,"HIDKeyboardModifierMappingDst": 0xFF00000009},

    {"HIDKeyboardModifierMappingSrc": 0x10000009B,"HIDKeyboardModifierMappingDst": 0xFF00000008},
    {"HIDKeyboardModifierMappingSrc": 0x70000003F,"HIDKeyboardModifierMappingDst": 0xFF00000008},

    {"HIDKeyboardModifierMappingSrc": 0xC000000B8,"HIDKeyboardModifierMappingDst": 0xC000000CD}
  ]
}'

/usr/bin/hidutil property --set "$(echo $MAPPING | tr -d ' ')"
