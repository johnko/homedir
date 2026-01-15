#!/usr/bin/env python3

import json
import os

HOME = os.environ.get("HOME")
LULU_RULES_FILE = f"{HOME}/bin/macos-settings/lulu/rules.json"

ALLOWED_HOSTS = [
    "2.fedora.pool.ntp.org",  # endpointAddr, /opt/homebrew/Cellar/podman/5.7.1/libexec/podman/gvproxy
    "api.cloudflare.com",  # endpointAddr, /opt/homebrew/Cellar/podman/5.7.1/libexec/podman/gvproxy
    "api.github.com",  # endpointAddr, com.microsoft.VSCode.helper:Developer ID Application: Microsoft Corporation (UBF8T346G9)
    "api.github.com",  # endpointAddr, io.podmandesktop.PodmanDesktop:Developer ID Application: Red Hat, Inc. (HYSCB8KRL2)
    "app-updates.agilebits.com",  # endpointAddr, com.1password.1password:Developer ID Application: AgileBits Inc. (2BUA8C4S2C)
    "b5n.1password.ca",  # endpointAddr, com.1password.1password:Developer ID Application: AgileBits Inc. (2BUA8C4S2C)
    "cache.agilebits.com",  # endpointAddr, com.1password.1password:Developer ID Application: AgileBits Inc. (2BUA8C4S2C)
    "cdn.discordapp.com",  # endpointAddr, com.hnc.Discord:Developer ID Application: Discord, Inc. (53Q6R32WPB)
    "chat.signal.org",  # endpointAddr, org.whispersystems.signal-desktop.helper.Renderer:Developer ID Application: Signal Messenger, LLC (U68MSDN6DR)
    "checkip.amazonaws.com",  # endpointAddr, /opt/homebrew/Cellar/podman/5.7.1/libexec/podman/gvproxy
    "checkip.amazonaws.com",  # endpointAddr, com.apple.curl
    "desktop.line-scdn.net",  # endpointAddr, jp.naver.line.mac
    "detectportal.firefox.com",  # endpointAddr, org.mozilla.firefox:Developer ID Application: Mozilla Corporation (43AQ936H96)
    "discord.com",  # endpointAddr, com.hnc.Discord:Developer ID Application: Discord, Inc. (53Q6R32WPB)
    "dl.cloudsmith.io",  # endpointAddr, /opt/homebrew/Cellar/podman/5.7.1/libexec/podman/gvproxy
    "dl.google.com",  # endpointAddr, /opt/homebrew/Cellar/podman/5.7.1/libexec/podman/gvproxy
    "downloads.cursor.com",  # endpointAddr, com.apple.curl
    "eu-central-1-1.aws.cloud2.influxdata.com",  # endpointAddr, com.apple.curl
    "formulae.brew.sh",  # endpointAddr, com.apple.curl
    "github.com",  # endpointAddr, com.apple.ssh
    "grafana.com",  # endpointAddr, /opt/homebrew/Cellar/podman/5.7.1/libexec/podman/gvproxy
    "hooks.slack.com",  # endpointAddr, /opt/homebrew/Cellar/podman/5.7.1/libexec/podman/gvproxy
    "itunes.apple.com",  # endpointAddr, /opt/homebrew/Cellar/mas/5.0.2/bin/mas
    "itunes.apple.com",  # endpointAddr, jp.naver.line.mac
    "lan.line.me",  # endpointAddr, jp.naver.line.mac
    "legy-us.aws.line-apps.com",  # endpointAddr, jp.naver.line.mac
    "ly.my.sentry.io",  # endpointAddr, jp.naver.line.mac
    "ly.my.sentry.io",  # endpointAddr, jp.naver.line.mac.LineCall
    "mise-versions.jdx.dev",  # endpointAddr, /opt/homebrew/Cellar/podman/5.7.1/libexec/podman/gvproxy
    "mise.jdx.dev",  # endpointAddr, /opt/homebrew/Cellar/podman/5.7.1/libexec/podman/gvproxy
    "mozilla.cloudflare-dns.com",  # endpointAddr, org.mozilla.firefox:Developer ID Application: Mozilla Corporation (43AQ936H96)
    "my.1password.ca",  # endpointAddr, com.1password.1password:Developer ID Application: AgileBits Inc. (2BUA8C4S2C)
    "my.1password.ca",  # endpointAddr, com.1password.op:Developer ID Application: AgileBits Inc. (2BUA8C4S2C)
    "my.1password.com",  # endpointAddr, com.1password.1password:Developer ID Application: AgileBits Inc. (2BUA8C4S2C)
    "obs.line-apps.com",  # endpointAddr, jp.naver.line.mac
    "ollama.com",  # endpointAddr, ai.ollama.ollama:Developer ID Application: Infra Technologies, Inc (3MU9H2V9Y9)
    "ollama.com",  # endpointAddr, com.electron.ollama:Developer ID Application: Infra Technologies, Inc (3MU9H2V9Y9)
    "podman-desktop.io",  # endpointAddr, io.podmandesktop.PodmanDesktop:Developer ID Application: Red Hat, Inc. (HYSCB8KRL2)
    "ports.ubuntu.com",  # endpointAddr, /opt/homebrew/Cellar/podman/5.7.1/libexec/podman/gvproxy
    "proxy.golang.org",  # endpointAddr, /opt/homebrew/Cellar/podman/5.7.1/libexec/podman/gvproxy
    "registry.ollama.ai",  # endpointAddr, ai.ollama.ollama:Developer ID Application: Infra Technologies, Inc (3MU9H2V9Y9)
    "registry.podman-desktop.io",  # endpointAddr, io.podmandesktop.PodmanDesktop:Developer ID Application: Red Hat, Inc. (HYSCB8KRL2)
    "stats.grafana.org",  # endpointAddr, /opt/homebrew/Cellar/podman/5.7.1/libexec/podman/gvproxy
    "stickershop.line-scdn.net",  # endpointAddr, jp.naver.line.mac
    "storage.googleapis.com",  # endpointAddr, /opt/homebrew/Cellar/podman/5.7.1/libexec/podman/gvproxy
    "sum.golang.org",  # endpointAddr, /opt/homebrew/Cellar/podman/5.7.1/libexec/podman/gvproxy
    "update.code.visualstudio.com",  # endpointAddr, com.microsoft.VSCode:Developer ID Application: Microsoft Corporation (UBF8T346G9)
    "update.googleapis.com",  # endpointAddr, com.google.GoogleUpdater:Developer ID Application: Google LLC (EQHXZ8M8AV)
    "updates.bravesoftware.com",  # endpointAddr, com.brave.Browser:Developer ID Application: Brave Software, Inc. (KL8N8XSYF4)
    "updates.signal.org",  # endpointAddr, com.apple.curl
    "uts-front.line-apps.com",  # endpointAddr, jp.naver.line.mac
    "www.podman-desktop.io",  # endpointAddr, io.podmandesktop.PodmanDesktop:Developer ID Application: Red Hat, Inc. (HYSCB8KRL2)
    "www.schemastore.org",  # endpointAddr, com.microsoft.VSCode.helper:Developer ID Application: Microsoft Corporation (UBF8T346G9)
]

try:
    # Open the file in read mode
    with open(LULU_RULES_FILE, "r", encoding="utf-8") as file:
        # Load the JSON data into a Python dictionary
        data = json.load(file)
    # You can now access and work with the data like any other Python dictionary
    # print(f"{data}")

    # Converting passive rules with port 53 to user rules
    for app_name in data:
        # Iterate through each rule per app
        for rule in data[app_name]:
            if rule["type"] == 4 and rule["endpointPort"] == "53":
                print()
                print(f"Converting app {app_name} rule {rule["uuid"]}")
                rule["type"] = 3
                print(f"{rule}")

    # Converting passive rulues with endpointAddr and endpointHost for each rule if either are not IPv4/IPv6 and not wildcard and in ALLOWED_HOSTS
    for app_name in data:
        # Iterate through each rule per app
        for rule in data[app_name]:
            import re

            ipv4_pattern = r"^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$"
            ipv6_pattern = (
                r"^[0-9a-fA-F]{1,4}:[0-9a-fA-F]{1,4}::?[0-9a-fA-F]{1,4}.*$|^::1$|^::$"
            )

            is_ipv4 = bool(re.match(ipv4_pattern, rule["endpointAddr"])) or (
                bool(re.match(ipv4_pattern, rule["endpointHost"]))
                if "endpointHost" in rule
                else False
            )
            is_ipv6 = bool(re.match(ipv6_pattern, rule["endpointAddr"])) or (
                bool(re.match(ipv6_pattern, rule["endpointHost"]))
                if "endpointHost" in rule
                else False
            )

            if (
                rule["type"] == 4
                and not is_ipv4
                and not is_ipv6
                and rule["endpointAddr"] != "*"
            ):
                if rule["endpointAddr"] in ALLOWED_HOSTS:
                    print()
                    print(f"Converting app {app_name} rule {rule['endpointAddr']}")
                    rule["type"] = 3
                    print(f"{rule}")

    # Write the updated rules back to file
    # print(f"{data}")
    with open(LULU_RULES_FILE, "w", encoding="utf-8") as file:
        json.dump(data, file, indent=2)

    # List passive rulues with endpointAddr and endpointHost for each rule if either are not IPv4/IPv6 and not wildcard
    print()
    print("========== ========== ========== ========== ========== ==========")
    print("Unhandled passive rules with hostnames:")
    print("========== ========== ========== ========== ========== ==========")
    for app_name in data:
        # Iterate through each rule per app
        for rule in data[app_name]:
            import re

            ipv4_pattern = r"^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$"
            ipv6_pattern = (
                r"^[0-9a-fA-F]{1,4}:[0-9a-fA-F]{1,4}::?[0-9a-fA-F]{1,4}.*$|^::1$|^::$"
            )

            is_ipv4 = bool(re.match(ipv4_pattern, rule["endpointAddr"])) or (
                bool(re.match(ipv4_pattern, rule["endpointHost"]))
                if "endpointHost" in rule
                else False
            )
            is_ipv6 = bool(re.match(ipv6_pattern, rule["endpointAddr"])) or (
                bool(re.match(ipv6_pattern, rule["endpointHost"]))
                if "endpointHost" in rule
                else False
            )

            if (
                rule["type"] == 4
                and not is_ipv4
                and not is_ipv6
                and rule["endpointAddr"] != "*"
            ):
                print(f"\"{rule['endpointAddr']}\",  # endpointAddr, {app_name}")
                if (
                    "endpointHost" in rule
                    and rule["endpointAddr"] != rule["endpointHost"]
                ):
                    # Seems optional in some rules
                    print(f"\"{rule['endpointHost']}\",  # endpointHost, {app_name}")


except FileNotFoundError:
    print("Error: The file LULU_RULES_FILE was not found.")
except json.JSONDecodeError as e:
    print(f"Error: Failed to decode JSON from the file - {e}")
