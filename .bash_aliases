#!/usr/bin/env bash

alias g=git
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'


# MacOs aliases
if [ -e /Users ]; then
    alias ls="ls -G"
    alias free="top -l 1 -s 0 | grep PhysMem | sed 's, (.*),,'"
else
    # Add an "alert" alias for long running commands.  Use like so:
    #   sleep 10; alert
    alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
    alias iftop="sudo /usr/sbin/iftop -nBP"
    alias dd="sudo /bin/dd status=progress"
    alias zl="sudo zfs list -oname,lused,usedds,usedchild,usedsnap,used,avail,refer,mountpoint,mounted,canmount"
    alias zll="sudo zfs list -oname,dedup,compress,compressratio,checksum,sync,quota,copies,atime,devices,exec,rdonly,setuid,xattr,acltype,aclinherit"
    alias zls="sudo zfs list -t snap -oname,used,avail,refer"
    alias zpl="sudo zpool list -oname,size,alloc,free,cap,dedup,health,frag,ashift,freeing,expandsz,expand,replace,readonly,altroot"
    alias zs="sudo zpool status"
    alias zio="sudo zpool iostat"
    function whatismydhcpserver() {
        for i in $(ps aux | grep -o '[/]var/lib/NetworkManager/\S*.lease') \
        $(ps aux | grep -o '[/]var/lib/dhcp/dhclient\S*.leases'); do
            [ -f "${i}" ] && grep "dhcp-server-identifier" "${i}"
        done
    }
    function copypubkey2clipboard() {
        for i in ~/.ssh/id_*.pub; do
            [ -e "${i}" ] && cat "${i}" | xsel --clipboard
        done
    }
fi

alias rsynca="rsync -viaP"
alias rsyncc="rsync -virchlmP"
alias rsynct="rsync -virthlmP"

function t() {
    tmux attach || tmux
}
function firstlastline() {
    head -n1 "${1}"
    tail -n1 "${1}"
}
# Usage: json '{"foo":42}' or echo '{"foo":42}' | json
function json() { # Syntax-highlight JSON strings or files
if [ -t 0 ]; then # argument
python -mjson.tool <<<"$*" | pygmentize -l javascript
else # pipe
    python -mjson.tool | pygmentize -l javascript
fi
}
# Usage: ppgep bash
function ppgrep() { pgrep "$@" | xargs --no-run-if-empty ps fp; }
function d() {
    case "${1}" in
        i)
        set -- docker images
        ;;
        p)
        set -- docker ps -a
        ;;
        e)
        shift
        set -- docker exec -it "${@}"
        ;;
        gca)
        # remove exited containers
        for i in $(docker ps -q -f status=exited); do
            docker rm "${i}"
        done
        # remove untagged docker images
        for i in $(docker images -q -f dangling=true); do
            docker rmi "${i}"
        done
        set --
        ;;
        gc)
        # remove untagged docker images
        for i in $(docker images -q -f dangling=true); do
            docker rmi "${i}"
        done
        set --
        ;;
        *)
        set -- docker "${@}"
        ;;
    esac
    "${@}"
}
function v() {
    case "${1}" in
        i)
        set -- vagrant box list
        ;;
        p)
        set -- vagrant status
        ;;
        e)
        shift
        set -- vagrant ssh -c "${@}"
        ;;
        s)
        set -- vagrant ssh
        ;;
        gc)
        set -- vagrant destroy -f
        ;;
        *)
        set -- vagrant "${@}"
        ;;
    esac
    "${@}"
}
