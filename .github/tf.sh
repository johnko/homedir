#!/usr/bin/env bash
set -eo pipefail

if [[ -e .envrc ]]; then
  set +x
  # hide secret env values from output
  # shellcheck disable=SC1091
  source .envrc
fi

if [[ -z $IAC_BIN ]]; then
  set -x
  export IAC_BIN=terraform
  set +x
fi

WORKSPACE="$1"
if [[ -z $WORKSPACE ]]; then
  echo "ERROR: missing 'WORKSPACE' as 1st argument"
  exit 1
fi
if [[ ! -d $WORKSPACE ]]; then
  echo "ERROR: invalid 'WORKSPACE', received '$WORKSPACE'"
  exit 1
fi
echo "WORKSPACE=$WORKSPACE"
pushd "$WORKSPACE"

ACTION="$2"
if [[ -z $ACTION ]]; then
  echo "ERROR: missing 'ACTION' as 1st argument"
  exit 1
fi
# transform the action arg into uppercase
SAFE_ACTION=$(echo "$ACTION" | tr '[:lower:]' '[:upper:]')
case $SAFE_ACTION in
  APPLY | AUTO | FMT | INIT | PLAN | VALIDATE)
    echo "ACTION=$ACTION"
    ;;
  *)
    echo "ERROR: invalid 'ACTION', received '$ACTION'"
    exit 1
    ;;
esac
echo "SAFE_ACTION=$SAFE_ACTION"

set -ux
$IAC_BIN fmt

set +x
if [[ "FMT" == "$SAFE_ACTION" ]]; then
  set -x
  exit 0
fi

set -x
set +e
$IAC_BIN init
TF_INIT_EXIT_CODE=$?
set +x
if [[ "INIT" == "$SAFE_ACTION" ]]; then
  set -x
  exit $TF_INIT_EXIT_CODE
elif [[ "0" != "$TF_INIT_EXIT_CODE" ]]; then
  $IAC_BIN providers
  set -e
  exit $TF_INIT_EXIT_CODE
fi

set -x
set +e
$IAC_BIN validate
TF_VALIDATE_EXIT_CODE=$?
set +x
if [[ "VALIDATE" == "$SAFE_ACTION" ]]; then
  set -x
  exit $TF_VALIDATE_EXIT_CODE
elif [[ "0" != "$TF_VALIDATE_EXIT_CODE" ]]; then
  set -e
  exit $TF_VALIDATE_EXIT_CODE
fi

set +x
if [[ "APPLY" == "$SAFE_ACTION" || "AUTO" == "$SAFE_ACTION" || "PLAN" == "$SAFE_ACTION" ]]; then
  if [[ -e _import.sh ]]; then
    set -x
    bash -ex _import.sh
  fi
fi

set +x
if [[ "PLAN" == "$SAFE_ACTION" ]]; then
  set -x
  set +e
  $IAC_BIN plan -detailed-exitcode -input=false -parallelism=1
  TF_PLAN_EXIT_CODE=$?
  set -e
  exit $TF_PLAN_EXIT_CODE
fi

set +x
if [[ "APPLY" == "$SAFE_ACTION" || "AUTO" == "$SAFE_ACTION" ]]; then
  AUTO_APPROVE_ARG=""
  if [[ "AUTO" == "$SAFE_ACTION" ]]; then
    AUTO_APPROVE_ARG="-auto-approve"
  fi
  set -x
  set +e
  $IAC_BIN apply $AUTO_APPROVE_ARG -input=false -parallelism=1
  TF_APPLY_EXIT_CODE=$?
  set -e
  exit $TF_APPLY_EXIT_CODE
fi

popd
