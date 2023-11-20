#!/usr/bin/env bash
set -eux

# source: https://www.reddit.com/r/macbook/comments/x3ovje/is_there_a_way_to_adjust_keyboard_brightness_from/
# other: https://hidutil-generator.netlify.app/

# replaces (dictation button) F5 and (focus button) F6 with keyboard brightness and eject to play/pause
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
