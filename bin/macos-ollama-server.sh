#!/usr/bin/env bash
set -eo pipefail

export CADDY_OLLAMA_API_DOMAIN=$(op read op://Private/1pcli-caddyollama-api-domain/host)
export CADDY_OLLAMA_API_ZONEID=$(op read op://Private/1pcli-caddyollama-api-domain/zoneid)
export CADDY_OLLAMA_API_RECORDID=$(op read op://Private/1pcli-caddyollama-api-domain/recordid)
export CADDY_OLLAMA_API_CFTOKEN=$(op read op://Private/1pcli-caddyollama-api-domain/credential)

export CADDY_OLLAMA_API_DOMAIN2=$(op read op://Private/1pcli-caddyollama-api-domain/host2)
export CADDY_OLLAMA_API_RECORDID2=$(op read op://Private/1pcli-caddyollama-api-domain/recordid2)

export CADDY_OLLAMA_API_USER1=$(op read op://Private/1pcli-caddyollama-api-user1/username)
export CADDY_OLLAMA_API_TEMP_PASSWORD1=$(op read op://Private/1pcli-caddyollama-api-user1/password)

export CADDY_OLLAMA_API_PUBKEY1=$(op read "op://Private/1pcli-caddyollama-api-pubkey1/public key")
export CADDY_OLLAMA_API_PUBKEY2=$(op read "op://Private/1pcli-caddyollama-api-pubkey2/public key")

if type docker-compose &>/dev/null; then
  DOCKERCOMPOSE_BIN="docker-compose"
else
  if type docker &>/dev/null; then
    DOCKERCOMPOSE_BIN="docker compose"
  fi
fi
if type podman &>/dev/null; then
  DOCKER_BIN="podman"
else
  if type docker &>/dev/null; then
    DOCKER_BIN="docker"
  fi
fi

relaunch_ollama() {
  case $1 in
    logs)
      $DOCKER_BIN logs -f caddyollama 2>&1 | sed "s,^{,\n{,"
      exit 0
      ;;
    pull)
      CONTINUE_CONFIG="$HOME/.continue/config.json"
      if type ollama &>/dev/null; then
        jq -r '.. | .model? // empty' $CONTINUE_CONFIG | sort -u | xargs -I{} bash -c "echo '==> {}'; ollama pull {}"
        exit 0
      else
        echo "ERROR: missing 'ollama'"
        exit 1
      fi
      ;;
    public)
      set +e
      set -u
      export OLLAMA_HOST=0.0.0.0:11434
      export OLLAMA_HOST_LAN=$(get-ip | tail -n1):11434

      # run caddy container so we can have some kind of authentication
      export CADDY_COMPOSE_FOLDER="$(dirname $0)/../ollama-caddy"
      if [[ -d $CADDY_COMPOSE_FOLDER ]]; then
        pushd "$CADDY_COMPOSE_FOLDER"
        # export CLOUDFLARE_IPV4=$(curl 'https://www.cloudflare.com/ips-v4/#' | tr "\n" ' ')
        # export CLOUDFLARE_IPV6=$(curl 'https://www.cloudflare.com/ips-v6/#' | tr "\n" ' ')
        # export CLOUDFLARE_IP_RANGES="127.0.0.1 192.168.2.0/24 $CLOUDFLARE_IPV4 $CLOUDFLARE_IPV6"

        # build temp container image
        touch Caddyfile
        $DOCKERCOMPOSE_BIN build --no-cache caddyollama

        export CADDY_OLLAMA_API_PASSWORD1=$( (
          echo $CADDY_OLLAMA_API_TEMP_PASSWORD1
          echo $CADDY_OLLAMA_API_TEMP_PASSWORD1
        ) | $DOCKER_BIN run --rm -it --entrypoint caddy caddyollama:local hash-password | tail -n 1)

        if [[ -z $CADDY_OLLAMA_API_PASSWORD1 ]]; then
          exit 1
        fi

        # replace env vars and generate config files
        envsubst <./Caddyfile.template >./Caddyfile
        envsubst <./ssh/authorized_keys.template >./ssh/authorized_keys
        envsubst <./dyndns/update-dns.sh.template >./dyndns/update-dns.sh

        # rebuild final container image
        $DOCKERCOMPOSE_BIN build caddyollama
        $DOCKERCOMPOSE_BIN build --no-cache ssh
        $DOCKERCOMPOSE_BIN build --no-cache dyndns
        # clean previous containers
        $DOCKERCOMPOSE_BIN down
        # run container
        $DOCKERCOMPOSE_BIN up -d
        popd
      else
        echo "ERROR: missing folder $CADDY_COMPOSE_FOLDER"
        exit 1
      fi
      ;;
    lan)
      export OLLAMA_HOST=$(get-ip | tail -n1):11434
      set -u
      ;;
    *)
      export OLLAMA_HOST=127.0.0.1:11434
      set -u
      ;;
  esac
  echo "OLLAMA_HOST=$OLLAMA_HOST"

  if type ollama &>/dev/null; then
    ollama serve
  else
    echo "ERROR: missing 'ollama'"
    exit 1
  fi
}

while true; do
  set +u
  relaunch_ollama $1
done
