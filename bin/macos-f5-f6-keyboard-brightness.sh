#!/usr/bin/env bash
set -eux

# source: https://www.reddit.com/r/macbook/comments/x3ovje/is_there_a_way_to_adjust_keyboard_brightness_from/
# other: https://hidutil-generator.netlify.app/
# other: https://mybyways.com/blog/script-to-re-map-macbook-pro-function-keys

# replaces (dictation button) F5 and (focus button) F6 with keyboard brightness and eject to play/pause

# fn_dict=0xc000000cf
# f5=0x70000003E
# fn_kbd_dec=0xff00000009

# fn_dnd=0x10000009b
# f6=0x70000003F
# fn_kbd_inc=0xff00000008

# eject=0xC000000B8
# fn_play=0xc000000cd

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
