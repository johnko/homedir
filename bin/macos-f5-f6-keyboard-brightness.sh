#!/usr/bin/env bash
set -eux

# source: https://www.reddit.com/r/macbook/comments/x3ovje/is_there_a_way_to_adjust_keyboard_brightness_from/

# replaces (dictation button) F5 and (focus button) F6 with keyboard brightness
/usr/bin/hidutil property --set "{\"UserKeyMapping\":[{\"HIDKeyboardModifierMappingSrc\": 0xC000000CF,\"HIDKeyboardModifierMappingDst\": 0xFF00000009},{\"HIDKeyboardModifierMappingSrc\": 0x10000009B, \"HIDKeyboardModifierMappingDst\": 0xFF00000008}]}"
