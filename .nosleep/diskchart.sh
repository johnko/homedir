#!/usr/bin/env bash
set -eu

[ ! -d "$HOME/.nosleep" ] && exit 0

# 1. Get the percentage from your script (Ensure it is a pure integer between 0 and 100)
# Example: if your script outputs "42%", strip the "%" sign
USED_PCT=$(df /System/Volumes/Data | sed 's, 0%,,' | grep -o -E '[0-9]+%' | tr -d '%')
[[ "$USED_PCT" -lt 0 ]] && USED_PCT=0
[[ "$USED_PCT" -gt 100 ]] && USED_PCT=100

# 2. Geometric Constants for Stroke Math
# A circle with radius 40 has a perfect circumference of exactly 251.327 (2 * pi * r)
RADIUS=40
CIRCUMFERENCE="251.327"
CENTER=100

# 3. Calculate stroke offsets using bc
# Determines how much of the ring color to draw
DASH_FILL=$(echo "scale=3; ($USED_PCT / 100) * $CIRCUMFERENCE" | bc -l)
DASH_EMPTY=$(echo "scale=3; $CIRCUMFERENCE - $DASH_FILL" | bc -l)

# 4. Output the complete standalone SVG
cat <<EOF > "$HOME/.nosleep/diskchart.svg"
<svg width="200" height="200" viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg">
  <!-- Background Gray Ring (Free Space) -->
  <circle cx="$CENTER" cy="$CENTER" r="$RADIUS"
          fill="none"
          stroke="#ffffff"
          stroke-width="80" />

  <!-- Foreground Blue Ring (Used Space) -->
  <!-- Rotated -90deg to start perfectly at 12 o'clock -->
  <circle cx="$CENTER" cy="$CENTER" r="$RADIUS"
          fill="none"
          stroke="#3ea0f1"
          stroke-width="80"
          stroke-dasharray="$DASH_FILL $DASH_EMPTY"
          transform="rotate(-90 $CENTER $CENTER)" />

  <!-- Inner Cutout (Creates the clean donut center) -->
  <circle cx="$CENTER" cy="$CENTER" r="45" fill="#ffffff" />

  <!-- Text Label in Center -->
  <text x="$CENTER" y="$((CENTER + 6))" text-anchor="middle" font-family="monospace" font-size="20" font-weight="bold" fill="#222222">${USED_PCT}%</text>
</svg>
EOF
