#!/usr/bin/env bash
set -euo pipefail

set -x

if [[ ! -e /Volumes/RAMDisk/.metadata_never_index ]]; then
  set +x
  echo "ERROR: missing /Volumes/RAMDisk"
  exit 1
fi

usage() {
  cat <<EOS
Usage:
  ${0##*/}  [create|destroy|info|list|ps|restart|stop|start]  -n NAME  -c [1-4]  -m [1-8]  -s [10-60]

Example:
  ${0##*/} create -n test -i 24.04 -c 1 -m 4 -s 20
  ${0##*/} start -n test
EOS
  exit 1
}

# parse args
set +ux
if [[ -z $1 ]]; then
  usage
else
  ACTN="$1"
  shift
fi
while getopts ":n:i:c:m:s:" o; do
  case "$o" in
    n)
      n=$OPTARG
      NAME=$n
      ;;
    i)
      i=$OPTARG
      ;;
    c)
      c=$OPTARG
      ((c >= 1 && c <= 4)) || usage
      CPUS=$c
      ;;
    m)
      m=$OPTARG
      ((m >= 1 && m <= 8)) || usage
      MEMS=$m
      ;;
    s)
      s=$OPTARG
      ((s >= 10 && s <= 60)) || usage
      STOR=$s
      ;;
    *)
      usage
      ;;
  esac
done
shift $((OPTIND - 1))
if [[ "create" == "$ACTN" ||
  "destroy" == "$ACTN" ||
  "info" == "$ACTN" ||
  "restart" == "$ACTN" ||
  "stop" == "$ACTN" ||
  "start" == "$ACTN" ]] && [[ -z $n ]]; then
  usage
fi
[[ -z $ISO ]] && ISO=24.04
[[ -z $CPUS ]] && CPUS=1
[[ -z $MEMS ]] && MEMS=1
[[ -z $STOR ]] && STOR=10
[[ -z $NIC ]] && NIC=$(ifconfig | grep -v '127.0.0.1' | grep -E "(^en|inet )" | grep -B1 'inet ' | grep '^en' | tail -n 1 | cut -d: -f1)
echo "ACTN=$ACTN"
echo "NAME=$NAME"
echo "ISO =$ISO"
echo "CPUS=$CPUS"
echo "MEMS=$MEMS"
echo "STOR=$STOR"
echo "NIC =$NIC"

stop_multipass_svc() {
  sudo launchctl unload /Library/LaunchDaemons/com.canonical.multipassd.plist
}
start_multipass_svc() {
  sudo launchctl load -w /Library/LaunchDaemons/com.canonical.multipassd.plist
}
mkdir_ramdisk_vm() {
  test -d /Volumes/RAMDisk/vm || install -d -v -m 755 /Volumes/RAMDisk/vm
}
mk_symlink_multipassd() {
  sudo ln -sf /Volumes/RAMDisk/vm/multipassd /var/root/Library/Application\ Support/multipassd
}

# perform the ACTN
set -ux
case $ACTN in
  create)
    if sudo test -L /var/root/Library/Application\ Support/multipassd; then
      if ! sudo ls -l /var/root/Library/Application\ Support/multipassd/; then
        if sudo test -d /var/root/Library/Application\ Support/multipassd.bkp; then
          stop_multipass_svc
          mkdir_ramdisk_vm
          sudo cp -a /var/root/Library/Application\ Support/multipassd.bkp /Volumes/RAMDisk/vm/multipassd
          start_multipass_svc
        fi
      fi
    elif sudo test -d /var/root/Library/Application\ Support/multipassd; then
      stop_multipass_svc
      mkdir_ramdisk_vm
      sudo test -d /var/root/Library/Application\ Support/multipassd.bkp || sudo cp -a /var/root/Library/Application\ Support/multipassd /var/root/Library/Application\ Support/multipassd.bkp
      sudo mv /var/root/Library/Application\ Support/multipassd /Volumes/RAMDisk/vm/multipassd
      mk_symlink_multipassd
      start_multipass_svc
    else
      stop_multipass_svc
      sudo install -d -v -g wheel -m 755 -o root /Volumes/RAMDisk/vm/multipassd
      mk_symlink_multipassd
      start_multipass_svc
    fi
    # sudo multipass get local.driver | grep qemu || sudo multipass set local.driver=qemu
    sudo multipass launch \
      -vvv \
      --name=$NAME \
      --cpus=$CPUS \
      --memory=${MEMS}G \
      --disk=${STOR}G \
      --network="name=$NIC,mode=auto" \
      --cloud-init=$(dirname $0)/../lab-squid-ramdisk/cloud-init.yaml \
      $ISO
    ;;
  destroy)
    set +e
    while sudo multipass list | grep $NAME; do
      sudo multipass stop $NAME
      sudo multipass delete $NAME
      sudo multipass purge
      sleep 1
    done
    ;;
  info)
    sudo multipass info $NAME
    ;;
  list)
    sudo multipass list
    ;;
  ps)
    ps aux | grep qemu
    ;;
  restart)
    sudo multipass stop $NAME
    sudo multipass start $NAME
    ;;
  start)
    sudo multipass start $NAME
    ;;
  stop)
    sudo multipass stop $NAME
    ;;
  *)
    usage
    ;;
esac
