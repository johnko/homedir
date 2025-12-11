#!/usr/bin/env bash
set -euxo pipefail

/usr/bin/caddy run --config /etc/caddy/Caddyfile
