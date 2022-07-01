alias g="git --no-pager"
alias k=kubectl
alias ka="kubectl -o wide"
alias tf=terraform
alias grep='grep --color=auto'
alias fgrep='grep -F --color=auto'
alias egrep='grep -E --color=auto'

# MacOs aliases
if [ -e /Users ]; then
  alias ls="ls -G"
  alias free="top -l 1 -s 0 | grep PhysMem | sed 's, (.*),,'"
  alias iftop="sudo /usr/local/sbin/iftop -nBP"
  ppgrep() {
    # Usage: ppgrep bash
    pgrep "$@" | xargs ps
  }
else
  alias ls='ls --color=auto'
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
  whatismydhcpserver() {
    for i in $(ps aux | grep -o '[/]var/lib/NetworkManager/\S*.lease') \
      $(ps aux | grep -o '[/]var/lib/dhcp/dhclient\S*.leases'); do
      [ -f "${i}" ] && grep "dhcp-server-identifier" "${i}"
    done
  }
  copypubkey2clipboard() {
    for i in ~/.ssh/id_*.pub; do
      [ -e "${i}" ] && cat "${i}" | xsel --clipboard
    done
  }
  ppgrep() {
    # Usage: ppgrep bash
    pgrep "$@" | xargs --no-run-if-empty ps fp
  }
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias rsynca="rsync -viaP --exclude-from=${HOME}/.rsync_exclude"
alias rsyncc="rsync -virchlmP --exclude-from=${HOME}/.rsync_exclude"
alias rsynct="rsync -virthlmP --exclude-from=${HOME}/.rsync_exclude"

# Linux 'which' doesn't have -s so we redirect output to /dev/null
if which git >/dev/null 2>&1; then
  # Use Git’s colored diff when available
  difff() {
    if [ -z "${1}" ]; then
      git --no-pager diff --ignore-space-change
    elif [ -z "${2}" ]; then
      git --no-pager diff --ignore-space-change "$@"
    else
      git --no-pager diff --no-index --ignore-space-change "$@"
    fi
  }
fi

t() {
  tmux attach || tmux
}

fetch_cert() {
  echo | openssl s_client -servername $1 -connect $1:443 2>/dev/null | openssl x509 -text
}

get-ip() {
  ifconfig | grep -v '127\.0\.0\.' | sed -e 's;broadcast.*;;' -e 's;Bcast.*;;' -e 's;netmast.*;;' -e 's;Mask.*;;' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'
}

firstlastline() {
  head -n1 "${1}"
  tail -n1 "${1}"
}

# Usage: json '{"foo":42}' or echo '{"foo":42}' | json
# Syntax-highlight JSON strings or files
json() {
  if [ -t 0 ]; then
    # has argument
    python -m json.tool <<<"$*" | pygmentize -l javascript
  else
    # is piped
    python -m json.tool | pygmentize -l javascript
  fi
}

alias d=docker
d-exec() {
  docker exec -it "${@}"
}
d-img() {
  docker image "${@}"
}
d-gc() {
  # remove untagged docker images
  docker image prune -f
  # for i in $(docker images -q -f dangling=true); do
  #     docker rmi "${i}"
  # done
}
d-gca() {
  # remove exited containers
  docker container prune -f
  # for i in $(docker ps -q -f status=exited); do
  #     docker rm "${i}"
  # done
  # remove untagged docker images
  docker image prune -f
  # for i in $(docker images -q -f dangling=true); do
  #     docker rmi "${i}"
  # done
}
d-net() {
  docker network "${@}"
}
d-psa() {
  docker ps -a "${@}"
}
d-runtmp() {
  docker run -it --rm "${@}"
}
d-vol() {
  docker volume "${@}"
}

alias v=vagrant
v-exec() {
  vagrant ssh -c "${@}"
}
v-img() {
  vagrant box list "${@}"
}
v-gc() {
  vagrant destroy -f "${@}"
}
v-psa() {
  vagrant status "${@}"
}
v-ssh() {
  vagrant ssh "${@}"
}

repos-gitbranches() {
  for i in $(find . -mindepth 1 -maxdepth 1 -type d); do
    if [ -e "${i}/.git" ]; then
      pushd "${i}" >/dev/null
      local branch=$(git branch | grep '^*' | awk '{print $NF}')
      echo "==> ${__YELLOW}${i} ${__CYAN}* ${branch}${__RESET}"
      popd >/dev/null
    fi
  done
}
repos-fetchorigin() {
  for i in $(find . -mindepth 1 -maxdepth 1 -type d); do
    if [ -e "${i}/.git" ]; then
      pushd "${i}" >/dev/null
      local branch=$(git branch | grep '^*' | awk '{print $NF}')
      local remoteorigin=$(git remote | head -n1)
      local remotebranch=$(git branch -va | grep "remotes/${remoteorigin}/HEAD" | awk '{print $NF}' | sed "s;${remoteorigin}/;;")
      if [ -z "${remoteorigin}" ]; then
        echo "==> ${__YELLOW}${i} ${__CYAN}* ${branch} ${__RED}* No remotes.${__RESET}"
      else
        local cmdfetch="git fetch ${remoteorigin} ${remotebranch}"
        echo "==> ${__YELLOW}${i} ${__CYAN}* ${branch} ${__GREEN}* Running: ${__PURPLE}${cmdfetch}${__RESET}"
        ${cmdfetch} 2>&1 | awk "{print \"        \"\$0}"
        if [ "${remotebranch}" == "${branch}" ]; then
          local cmdmerge="git merge --ff-only ${remoteorigin}/${remotebranch}"
          echo "    ${__GREEN}* Running: ${__PURPLE}${cmdmerge}${__RESET}"
          ${cmdmerge} 2>&1 | awk "{print \"        \"\$0}"
        fi
      fi
      popd >/dev/null
    fi
  done
}
