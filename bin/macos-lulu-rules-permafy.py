#!/usr/bin/env python3

import json
import os
import re
from pprint import pp

HOME = os.environ.get("HOME")
LULU_RULES_FILE = f"{HOME}/bin/macos-settings/lulu/rules.json"

ALLOWED_HOSTS = [
    "2.fedora.pool.ntp.org",  # endpointAddr, /opt/homebrew/Cellar/podman/5.7.1/libexec/podman/gvproxy
    "api.cloudflare.com",  # endpointAddr, /opt/homebrew/Cellar/podman/5.7.1/libexec/podman/gvproxy
    "api.github.com",  # endpointAddr, com.microsoft.VSCode.helper:Developer ID Application: Microsoft Corporation (UBF8T346G9)
    "api.github.com",  # endpointAddr, io.podmandesktop.PodmanDesktop:Developer ID Application: Red Hat, Inc. (HYSCB8KRL2)
    "api.pwnedpasswords.com",  # endpointAddr, com.1password.1password:Developer ID Application: AgileBits Inc. (2BUA8C4S2C)
    "api2.cursor.sh",  # endpointAddr, com.github.Electron.helper:Developer ID Application: Hilary Stout (VDXQ22DGB9)
    "api2.cursor.sh",  # endpointAddr, com.todesktop.230313mzl4w4u92:Developer ID Application: Hilary Stout (VDXQ22DGB9)
    "api3.cursor.sh",  # endpointAddr, com.github.Electron.helper:Developer ID Application: Hilary Stout (VDXQ22DGB9)
    "api4.cursor.sh",  # endpointAddr, com.github.Electron.helper:Developer ID Application: Hilary Stout (VDXQ22DGB9)
    "app-updates.agilebits.com",  # endpointAddr, com.1password.1password:Developer ID Application: AgileBits Inc. (2BUA8C4S2C)
    "b5n.1password.ca",  # endpointAddr, com.1password.1password:Developer ID Application: AgileBits Inc. (2BUA8C4S2C)
    "cache.agilebits.com",  # endpointAddr, com.1password.1password:Developer ID Application: AgileBits Inc. (2BUA8C4S2C)
    "cdn.discordapp.com",  # endpointAddr, com.hnc.Discord:Developer ID Application: Discord, Inc. (53Q6R32WPB)
    "chat.signal.org",  # endpointAddr, org.whispersystems.signal-desktop.helper.Renderer:Developer ID Application: Signal Messenger, LLC (U68MSDN6DR)
    "checkip.amazonaws.com",  # endpointAddr, /opt/homebrew/Cellar/podman/5.7.1/libexec/podman/gvproxy
    "checkip.amazonaws.com",  # endpointAddr, com.apple.curl
    "checkpoint-api.hashicorp.com",  # endpointAddr, terraform:Developer ID Application: Hashicorp, Inc. (D38WU7D763)
    "cix.line-apps.com",  # endpointAddr, jp.naver.line.mac
    "codeload.github.com",  # endpointAddr, com.microsoft.VSCode.helper:Developer ID Application: Microsoft Corporation (UBF8T346G9)
    "desktop.line-scdn.net",  # endpointAddr, jp.naver.line.mac
    "detectportal.firefox.com",  # endpointAddr, org.mozilla.firefox:Developer ID Application: Mozilla Corporation (43AQ936H96)
    "discord.com",  # endpointAddr, com.hnc.Discord:Developer ID Application: Discord, Inc. (53Q6R32WPB)
    "dl.cloudsmith.io",  # endpointAddr, /opt/homebrew/Cellar/podman/5.7.1/libexec/podman/gvproxy
    "dl.google.com",  # endpointAddr, /opt/homebrew/Cellar/podman/5.7.1/libexec/podman/gvproxy
    "download-installer.cdn.mozilla.net",  # endpointAddr, com.apple.curl
    "downloads.cursor.com",  # endpointAddr, com.apple.curl
    "eu-central-1-1.aws.cloud2.influxdata.com",  # endpointAddr, com.apple.curl
    "formulae.brew.sh",  # endpointAddr, com.apple.curl
    "ghcr.io",  # endpointAddr, com.apple.curl
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
    "mobile.events.data.microsoft.com",  # endpointAddr, com.github.Electron.helper:Developer ID Application: Hilary Stout (VDXQ22DGB9)
    "mozilla.cloudflare-dns.com",  # endpointAddr, org.mozilla.firefox:Developer ID Application: Mozilla Corporation (43AQ936H96)
    "my.1password.ca",  # endpointAddr, com.1password.1password:Developer ID Application: AgileBits Inc. (2BUA8C4S2C)
    "my.1password.ca",  # endpointAddr, com.1password.op:Developer ID Application: AgileBits Inc. (2BUA8C4S2C)
    "my.1password.com",  # endpointAddr, com.1password.1password:Developer ID Application: AgileBits Inc. (2BUA8C4S2C)
    "objective-see.org",  # endpointAddr, com.objective-see.lulu.app:Developer ID Application: Objective-See, LLC (VBG97UB4TA)
    "obs.line-apps.com",  # endpointAddr, jp.naver.line.mac
    "obs.line-scdn.net",  # endpointAddr, jp.naver.line.mac
    "ollama.com",  # endpointAddr, ai.ollama.ollama:Developer ID Application: Infra Technologies, Inc (3MU9H2V9Y9)
    "ollama.com",  # endpointAddr, com.electron.ollama:Developer ID Application: Infra Technologies, Inc (3MU9H2V9Y9)
    "pkg-containers.githubusercontent.com",  # endpointAddr, com.apple.curl
    "podman-desktop.io",  # endpointAddr, io.podmandesktop.PodmanDesktop:Developer ID Application: Red Hat, Inc. (HYSCB8KRL2)
    "ports.ubuntu.com",  # endpointAddr, /opt/homebrew/Cellar/podman/5.7.1/libexec/podman/gvproxy
    "proxy.golang.org",  # endpointAddr, /opt/homebrew/Cellar/podman/5.7.1/libexec/podman/gvproxy
    "raw.githubusercontent.com",  # endpointAddr, com.apple.curl
    "rectangleapp.com",  # endpointAddr, com.knollsoft.Rectangle:Developer ID Application: Ryan Hanson (XSYZ3E4B7D)
    "registry.ollama.ai",  # endpointAddr, ai.ollama.ollama:Developer ID Application: Infra Technologies, Inc (3MU9H2V9Y9)
    "registry.podman-desktop.io",  # endpointAddr, io.podmandesktop.PodmanDesktop:Developer ID Application: Red Hat, Inc. (HYSCB8KRL2)
    "release-assets.githubusercontent.com",  # endpointAddr, com.apple.curl
    "secure.gravatar.com",  # endpointAddr, /opt/homebrew/Cellar/podman/5.7.1/libexec/podman/gvproxy
    "stats.grafana.org",  # endpointAddr, /opt/homebrew/Cellar/podman/5.7.1/libexec/podman/gvproxy
    "stickershop.line-scdn.net",  # endpointAddr, jp.naver.line.mac
    "storage.googleapis.com",  # endpointAddr, /opt/homebrew/Cellar/podman/5.7.1/libexec/podman/gvproxy
    "sum.golang.org",  # endpointAddr, /opt/homebrew/Cellar/podman/5.7.1/libexec/podman/gvproxy
    "update.code.visualstudio.com",  # endpointAddr, com.microsoft.VSCode:Developer ID Application: Microsoft Corporation (UBF8T346G9)
    "update.googleapis.com",  # endpointAddr, com.google.GoogleUpdater:Developer ID Application: Google LLC (EQHXZ8M8AV)
    "updates-cdn.bravesoftware.com",  # endpointAddr, com.apple.curl
    "updates.bravesoftware.com",  # endpointAddr, com.brave.Browser:Developer ID Application: Brave Software, Inc. (KL8N8XSYF4)
    "updates.signal.org",  # endpointAddr, com.apple.curl
    "us-only.gcpp.cursor.sh",  # endpointAddr, com.github.Electron.helper:Developer ID Application: Hilary Stout (VDXQ22DGB9)
    "uts-front.line-apps.com",  # endpointAddr, jp.naver.line.mac
    "watchtower.1password.com",  # endpointAddr, com.1password.1password:Developer ID Application: AgileBits Inc. (2BUA8C4S2C)
    "www.podman-desktop.io",  # endpointAddr, io.podmandesktop.PodmanDesktop:Developer ID Application: Red Hat, Inc. (HYSCB8KRL2)
    "www.schemastore.org",  # endpointAddr, com.microsoft.VSCode.helper:Developer ID Application: Microsoft Corporation (UBF8T346G9)
]

ALLOWED_IPV4_PATTERNS = [
    r"^10\.88\.111\.\d{1,3}$",
    r"^1\.1\.1\.1$",
    r"^8\.8\.8\.8$",
    r"^142\.250\.137\.(9[0-9])$",
    r"^142\.250\.137\.(10[0-9]|11[0-9]|12[0-9]|13[0-9])$",
    r"^142\.250\.139\.(9[0-9])$",
    r"^142\.250\.139\.(10[0-9]|11[0-9]|12[0-9]|13[0-9]|14[0-9]|19[0-9])$",
    r"^2\.16\.170\.(165|166|173|216)$",
    r"^13\.107\.(213|246)\.(35|36)$",
    r"^13\.225\.196\.(20|38|79)$",
    r"^13\.227\.246\.(51|78|86|95|98)$",
    r"^13\.32\.205\.(115|80|82)$",
    r"^18\.154\.185\.(100|52|73)$",
    r"^18\.245\.104\.(101|40|61|70)$",
    r"^18\.67\.17\.(105|113|128|51|85)$",
    r"^20\.201\.192\.(30|34|54)$",
    r"^23\.223\.17\.(197|201|202|203|205|207|208|209|210|211)$",
    r"^23\.227\.(38|39)\.(32|200)$",
    r"^31\.13\.80\.(12|174|36|52|53|6|8)$",
    r"^35\.186\.224\.(24|38|39|9)$",
    r"^40\.90\.8\.(111|62|68)$",
    r"^45\.57\.(90|91)\.1$",
    r"^52\.85\.12\.(105|107|26|34|99)$",
    r"^76\.76\.21\.(21|22)$",
    r"^140\.82\.(112|113|114)\.(3|4|26|5)$",
    r"^151\.101\.(1|127|129|130|131|193|194|195|3|65|67)\.(140|91|42|132|208)$",
    r"^162\.159\.(128|130|136|137|140|152|153|61)\.(232|233|234|235|98|4|3)$",
    r"^172\.64\.(41|80|153)\.(1|3|54)$",
    r"^185\.199\.(108|109|110|111)\.(133|153|154)$",
    r"^199\.232\.(210|214)\.(248|250|251)$",
]

ALLOWED_APP_PORTS = [
    {
        "apps": ["/opt/homebrew/Cellar/podman/5.7.1/libexec/podman/gvproxy"],
        "ports": [123],
    },
    {
        "apps": [
            "com.google.Chrome.helper:Developer ID Application: Google LLC "
            "(EQHXZ8M8AV)"
        ],
        "ports": [3478, 5222, 5228, 5353, 19302],
    },
    {
        "apps": [
            "com.hnc.Discord.helper.Renderer:Developer ID Application: "
            "Discord, Inc. (53Q6R32WPB)"
        ],
        "ports": [
            19295,
            19296,
            19299,
            19304,
            19314,
            19316,
            19317,
            19325,
            19332,
            19333,
            19335,
            19341,
            50001,
            50002,
            50003,
            50004,
        ],
    },
    {
        "apps": [
            "com.hnc.Discord.helper:Developer ID Application: Discord, Inc. "
            "(53Q6R32WPB)"
        ],
        "ports": [2053, 2083],
    },
    {"apps": ["jp.naver.line.mac.LineCall"], "ports": [29494]},
]

try:
    # Open the file in read mode
    with open(LULU_RULES_FILE, "r", encoding="utf-8") as file:
        # Load the JSON data into a Python dictionary
        data = json.load(file)
    # You can now access and work with the data like any other Python dictionary
    # print(f"{data}")

    print()
    print("=" * 60)
    print("Converting passive rules with port 53 to user rules")
    print("=" * 60)
    for app_name in data:
        # Iterate through each rule per app
        for rule in data[app_name]:
            if rule["type"] == 4 and rule["endpointPort"] == "53":
                print()
                print(f"Converting app {app_name} rule {rule["uuid"]}")
                rule["type"] = 3
                print(f"{rule}")

    print()
    print("=" * 60)
    print(
        "Converting passive rulues with endpointAddr and endpointHost for each rule if either are not IPv4/IPv6 and not wildcard and in ALLOWED_HOSTS"
    )
    print("=" * 60)
    for app_name in data:
        # Iterate through each rule per app
        for rule in data[app_name]:
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

    print()
    print("=" * 60)
    print("Converting passive rules with ALLOWED_IPV4_PATTERNS to user rules")
    print("=" * 60)
    for app_name in data:
        # Iterate through each rule per app
        for rule in data[app_name]:
            for pattern in ALLOWED_IPV4_PATTERNS:

                is_allowed_ipv4 = bool(re.match(pattern, rule["endpointAddr"])) or (
                    bool(re.match(pattern, rule["endpointHost"]))
                    if "endpointHost" in rule
                    else False
                )

                if rule["type"] == 4 and is_allowed_ipv4:
                    print()
                    print(f"Converting app {app_name} rule {rule['endpointAddr']}")
                    rule["type"] = 3
                    print(f"{rule}")

    print()
    print("=" * 60)
    print("Converting passive rules with ALLOWED_APP_PORTS to user rules")
    print("=" * 60)
    for app_name in data:
        # Iterate through each rule per app
        for rule in data[app_name]:
            for allowed_pair in ALLOWED_APP_PORTS:
                if (
                    rule["type"] == 4
                    and int(rule["endpointPort"]) in allowed_pair["ports"]
                    and rule["key"] in allowed_pair["apps"]
                ):
                    print()
                    print(
                        f"Converting app {app_name} rule {rule['endpointAddr']} port {rule['endpointPort']}"
                    )
                    rule["type"] = 3
                    print(f"{rule}")

    print()
    print("=" * 60)
    print("Write the updated rules back to file")
    print("=" * 60)
    # print(f"{data}")
    with open(LULU_RULES_FILE, "w", encoding="utf-8") as file:
        json.dump(data, file, indent=2)

    print()
    print("=" * 60)
    print("Unhandled passive rules with hostnames:")
    print("=" * 60)
    # List passive rulues with endpointAddr and endpointHost for each rule if either are not IPv4/IPv6 and not wildcard
    for app_name in data:
        # Iterate through each rule per app
        for rule in data[app_name]:
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

    print()
    print("=" * 60)
    print("Unhandled passive rules without hostnames:")
    print("=" * 60)
    # List passive rules not in ALLOWED_IPV4_PATTERNS
    for app_name in data:
        # Iterate through each rule per app
        for rule in data[app_name]:
            printed = False
            for pattern in ALLOWED_IPV4_PATTERNS:

                is_allowed_ipv4 = bool(re.match(pattern, rule["endpointAddr"])) or (
                    bool(re.match(pattern, rule["endpointHost"]))
                    if "endpointHost" in rule
                    else False
                )

                if rule["type"] == 4 and not is_allowed_ipv4 and not printed:
                    print(f"\"{rule['endpointAddr']}\",  # endpointAddr, {app_name}")
                    if (
                        "endpointHost" in rule
                        and rule["endpointAddr"] != rule["endpointHost"]
                    ):
                        # Seems optional in some rules
                        print(
                            f"\"{rule['endpointHost']}\",  # endpointHost, {app_name}"
                        )
                    printed = True

    print()
    print("=" * 60)
    print("Unhandled passive rules with non standard ports:")
    print("=" * 60)
    # List passive rules not in ALLOWED_APP_PORTS
    unhandled_apps_ports = {}
    for app_name in data:
        # Iterate through each rule per app
        for rule in data[app_name]:
            if rule["type"] == 4 and int(rule["endpointPort"]) not in [80, 443, 53]:
                if app_name not in unhandled_apps_ports:
                    unhandled_apps_ports[app_name] = {"apps": [app_name], "ports": []}
                if (
                    int(rule["endpointPort"])
                    not in unhandled_apps_ports[app_name]["ports"]
                ):
                    unhandled_apps_ports[app_name]["ports"].append(
                        int(rule["endpointPort"])
                    )
                print(
                    f"# {rule["endpointPort"]} \"{rule['endpointAddr']}\",  # endpointAddr, {app_name}"
                )
                if (
                    "endpointHost" in rule
                    and rule["endpointAddr"] != rule["endpointHost"]
                ):
                    # Seems optional in some rules
                    print(
                        f"# {rule["endpointPort"]} \"{rule['endpointHost']}\",  # endpointHost, {app_name}"
                    )
    pp([x for x in unhandled_apps_ports.values()])


except FileNotFoundError:
    print(f"Error: The file {LULU_RULES_FILE} was not found.")
except json.JSONDecodeError as e:
    print(f"Error: Failed to decode JSON from the file - {e}")
