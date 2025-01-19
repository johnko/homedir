#!/usr/bin/env bash
set -eux

if [[ ! -e /Volumes/RAMDisk/.metadata_never_index ]] ; then
  set +x
  echo "ERROR: missing /Volumes/RAMDisk"
  exit 1
fi

if [[ -e /Applications/UTM.app/Contents/MacOS/utmctl && ! -e ${HOME}/bin/utmctl ]] ; then
  ln -sf /Applications/UTM.app/Contents/MacOS/utmctl ${HOME}/bin/utmctl
fi

usage() {
  cat <<EOS
Usage:
  ${0##*/}  [create|destroy|info|list|ps|restart|start|stop|unmount-boot-iso]  -n NAME  [-i iso-name]  [-c 1-4]  [-m 1-8]  [-s 10-60]

Example:
  ${0##*/} create -n test -i ubuntu-22 -c 1 -m 4 -s 40
  ${0##*/} start -n test
  ${0##*/} unmount-boot-iso -n test
  ${0##*/} start -n test
  ${0##*/} destroy -n test
EOS
  exit 1
}

# parse args
set +ux
if [[ -z "$1" ]] ; then
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
      (( c >= 1 && c <= 4 )) || usage
      CPUS=$c
      ;;
    m)
      m=$OPTARG
      (( m >= 1 && m <= 8 )) || usage
      MEMS=$m
      ;;
    s)
      s=$OPTARG
      (( s >= 10 && s <= 60 )) || usage
      STOR=$s
      ;;
    *)
      usage
      ;;
  esac
done
shift $((OPTIND-1))
if  [ "create" = "$ACTN" -o \
      "destroy" = "$ACTN" -o \
      "info" = "$ACTN" -o \
      "restart" = "$ACTN" -o \
      "stop" = "$ACTN" -o \
      "start" = "$ACTN" ] && [[ -z "$n" ]] ; then
    usage
fi
if [ "create" = "$ACTN" ] && [[ -z "$i" ]] ; then
  usage
fi
if [[ -n "$i" ]] ; then
  ISO=$( find ${HOME}/iso -name '*.iso' | grep -i "$i" )
  if [[ -z "$ISO" ]] ; then
    usage
  fi
fi
CLOUD_INIT_ISO=$( find ${HOME}/iso -name 'cloudinit.iso' )
[[ -z "$CPUS" ]] && CPUS=1
[[ -z "$MEMS" ]] && MEMS=1
[[ -z "$STOR" ]] && STOR=10
[[ -z "$NIC" ]] && NIC=$(ifconfig | grep -v '127.0.0.1' | grep -E "(^en|inet )" | grep -B1 'inet ' | grep '^en' | cut -d: -f1)
echo "ACTN=$ACTN"
echo "NAME=$NAME"
echo "ISO =$ISO"
echo "CPUS=$CPUS"
echo "MEMS=$MEMS"
echo "STOR=$STOR"
echo "NIC =$NIC"

mkdir_ramdisk_vm() {
  test -d /Volumes/RAMDisk/vm || install -d -v -m 755 /Volumes/RAMDisk/vm
}
mk_symlink_utmdoc() {
  ln -sf /Volumes/RAMDisk/vm/utmdocuments ${HOME}/Library/Containers/com.utmapp.UTM/Data/Documents
}

# perform the ACTN
set -ux
case $ACTN in
  create)
    if test -L ${HOME}/Library/Containers/com.utmapp.UTM/Data/Documents ; then
      if ! ls -l ${HOME}/Library/Containers/com.utmapp.UTM/Data/Documents/ ; then
        if test -d ${HOME}/Library/Containers/com.utmapp.UTM/Data/Documents.bkp ; then
          mkdir_ramdisk_vm
          # cp -a ${HOME}/Library/Containers/com.utmapp.UTM/Data/Documents.bkp /Volumes/RAMDisk/vm/utmdocuments
        fi
      fi
    elif test -d ${HOME}/Library/Containers/com.utmapp.UTM/Data/Documents ; then
      mkdir_ramdisk_vm
      # test -d ${HOME}/Library/Containers/com.utmapp.UTM/Data/Documents.bkp || cp -a ${HOME}/Library/Containers/com.utmapp.UTM/Data/Documents ${HOME}/Library/Containers/com.utmapp.UTM/Data/Documents.bkp
      # mv ${HOME}/Library/Containers/com.utmapp.UTM/Data/Documents /Volumes/RAMDisk/vm/utmdocuments
      # mk_symlink_utmdoc
    else
      install -d -v -m 755 /Volumes/RAMDisk/vm/utmdocuments
      # mk_symlink_utmdoc
    fi
    osascript -e '
tell application "UTM"
  --- specify a boot ISO
  set iso to POSIX file "'$ISO'"
  set cloudinit to POSIX file "'$CLOUD_INIT_ISO'"
  set vm to virtual machine named "Linux"
  duplicate vm with properties {backend:qemu, configuration:{name:"'$NAME'", architecture:"aarch64", machine:"virt", cpu cores:'$CPUS', memory:'$(($MEMS*1000))', network interfaces:{{index:0, mode:bridged, host interface:"'$NIC'"}}, drives:{{removable:true, source:iso}, {removable:true, source:cloudinit}, {guest size:'$(($STOR*1000))'}}}}
  --- note the default options for a new VM is no display, one PTTY serial port, and one shared network
  --- so we used duplicate above
end tell
'
    osascript -e '
tell application "UTM"
  set vm to virtual machine named "'$NAME'"
  set config to configuration of vm
  set iso to POSIX file "'$ISO'"
  set cloudinit to POSIX file "'$CLOUD_INIT_ISO'"
  set i to id of item 1 of drives of config
  set item 1 of drives of config to {id:i, source:iso}
  set i to id of item 2 of drives of config
  set item 2 of drives of config to {id:i, source:cloudinit}
  update configuration of vm with config
end tell
'
#     osascript '
# tell application "UTM"
#   --- create an Apple VM for booting Linux (only supported on macOS 13+)
#   make new virtual machine with properties {backend:apple, configuration:{name:"'$NAME'", drives:{{removable:true, source:iso}, {guest size:'$(($STOR*1024))'}}}}
# end tell
# '
    set +x
    echo "REMINDER: find the vm in UTM app and right click and 'Move...' it to /Volumes/RAMDisk/vm"
    ;;
  destroy)
    set +e
    while utmctl list | grep $NAME ; do
      utmctl stop $NAME
      utmctl delete $NAME
      sleep 1
    done
    ;;
  info)
    utmctl status $NAME
    utmctl ip-address $NAME
    ;;
  list)
    utmctl list
    ;;
  ps)
    ps aux | grep qemu
    ;;
  restart)
    utmctl stop $NAME
    utmctl start $NAME
    ;;
  start)
    utmctl start $NAME
    set +x
    echo "REMINDER: add 'autoinstall' on the 'linux' boot line"
    ;;
  stop)
    utmctl stop $NAME
    ;;
  unmount-boot-iso)
    set +e
    utmctl stop $NAME
    osascript -e '
tell application "UTM"
  set vm to virtual machine named "'$NAME'"
  set config to configuration of vm
  set cloudinit to POSIX file "'$CLOUD_INIT_ISO'"
  set i to id of item 1 of drives of config
  set item 1 of drives of config to {id:i, source:cloudinit}
  set i to id of item 2 of drives of config
  set item 2 of drives of config to {id:i, source:cloudinit}
  update configuration of vm with config
end tell
'
    set +x
    echo "REMINDER: find the vm in UTM app and right click and 'Move...' it to /Volumes/RAMDisk/vm"
    ;;
  *)
    usage
    ;;
esac
