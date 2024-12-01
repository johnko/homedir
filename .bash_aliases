alias g="git --no-pager"
alias gs="git s"
alias gd="git d"
alias k=kubectl
alias kk="kubectl -n kube-system"
alias ka="kubectl -o wide"
alias tf=terraform
alias grep='grep --color=auto'
alias fgrep='grep -F --color=auto'
alias egrep='grep -E --color=auto'
alias history='history -i'

# MacOs aliases
if [ -e /Users ]; then
  alias ls="ls -1G"
  alias free="top -l 1 -s 0 | grep PhysMem | sed 's, (.*),,'"
  alias iftop="sudo /usr/local/sbin/iftop -nBP"
  ppgrep() {
    # Usage: ppgrep bash
    pgrep "$@" | xargs ps
  }
else
  alias ls='ls --color=auto -1'
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
d-prune() {
  docker system prune -a --volumes
}
d-psa() {
  docker ps -a "${@}"
}
d-runtmp() {
  docker run -it --rm "${@}"
}
d-s() {
  docker image ls
  docker volume ls
  docker ps -a
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
      local branch=$(git branch --show-current)
      echo "==> ${__YELLOW}${i} ${__CYAN}* ${branch}${__RESET}"
      popd >/dev/null
    fi
  done
}
repos-fetchorigin() {
  for i in $(find . -mindepth 1 -maxdepth 1 -type d); do
    if [ -e "${i}/.git" ]; then
      pushd "${i}" >/dev/null
      local branch=$(git branch --show-current)
      local remoteorigin=$(git remote | grep origin | head -n1)
      local remotebranch=$(git branch -va | grep "remotes/${remoteorigin}/HEAD" | awk '{print $NF}' | sed "s;${remoteorigin}/;;")
      if [ -z "${remoteorigin}" ]; then
        echo "==> ${__YELLOW}${i} ${__CYAN}* ${branch} ${__RED}* No remotes.${__RESET}"
      else
        local cmdfetch="git fetch ${remoteorigin} ${remotebranch}"
        echo "==> ${__YELLOW}${i} ${__CYAN}* ${branch} ${__GREEN}* Running: ${__PURPLE}${cmdfetch}${__RESET}"
        eval ${cmdfetch} 2>&1 | awk "{print \"        \"\$0}"
        if [ "${remotebranch}" = "${branch}" ]; then
          local cmdmerge="git merge --ff-only ${remoteorigin}/${remotebranch}"
          echo "    ${__GREEN}* Running: ${__PURPLE}${cmdmerge}${__RESET}"
          eval ${cmdmerge} 2>&1 | awk "{print \"        \"\$0}"
        fi
      fi
      popd >/dev/null
    fi
  done
}
repos-updatemaster() {
  TMP_BRANCH=tmp/tmp$(date +%s)
  for i in $(find . -mindepth 1 -maxdepth 1 -type d); do
    if [ -e "${i}/.git" ]; then
      pushd "${i}" >/dev/null
      echo "==> ${__YELLOW}${i}${__RESET}"
      DEFAULT_BRANCH=master
      if git branch -a | grep -q 'remotes/origin/main'; then
        DEFAULT_BRANCH=main
      fi
      git checkout -b $TMP_BRANCH
      git fetch origin $DEFAULT_BRANCH
      git branch -D $DEFAULT_BRANCH || true
      git checkout -b $DEFAULT_BRANCH --track origin/$DEFAULT_BRANCH
      git branch -D $TMP_BRANCH
      popd >/dev/null
    fi
  done
}
repos-status() {
  for i in $(find . -mindepth 1 -maxdepth 1 -type d); do
    if [ -e "${i}/.git" ]; then
      pushd "${i}" >/dev/null
      echo "==> ${__YELLOW}${i}${__RESET}"
      git status -s
      popd >/dev/null
    fi
  done
}
repos-renovate() {
  for i in $(find . -mindepth 1 -maxdepth 1 -type d); do
    if [ -e "${i}/.git" ]; then
      pushd "${i}" >/dev/null
      echo "==> ${__YELLOW}${i}${__RESET}"
      git remote prune origin
      git branch -a | grep renovate || true
      popd >/dev/null
    fi
  done
}
repos-tmptmp() {
  for i in $(find . -mindepth 1 -maxdepth 1 -type d); do
    if [ -e "${i}/.git" ]; then
      pushd "${i}" >/dev/null
      echo "==> ${__YELLOW}${i}${__RESET}"
      git branch -a | grep tmp/tmp || true
      popd >/dev/null
    fi
  done
}

aws-ssm() {
  ec2name="$1"
  aws ssm start-session --target $(aws ec2 describe-instances --filters '[{"Name":"tag:Name","Values":["'$ec2name'"]},{"Name":"instance-state-name","Values":["running"]}]' --query "Reservations[0].Instances[0].InstanceId" --output text)
}

helmtemplate() {
  helm template --atomic -f $1 -f ~/test-secrets-template.yaml -n$2 $3 .
}
helmvalidate() {
  helm template --atomic -f $1 -f ~/test-secrets-template.yaml -n$2 $3 . | kubectl apply --dry-run=client -f -
}
helmdryrun() {
  helm upgrade --atomic --dry-run -f $1 -n$2 $3 .
}
kubectldryrun() {
  kubectl apply --dry-run=client -f -
}
kubectlpermissions() {
  kubectl auth can-i --list --namespace $1
}
kubectlnodeupgradestuckpods() {
  for i in $( kubectl get node | grep SchedulingDisabled | awk -F. '{print $1}' ); do kubectl get pod -A -o wide | grep $i | grep -v Completed ; done
}
kubectlnodeupgraderollstrategy() {
  kubectl get deployment -A -o yaml | grep -E '(^    name:|maxUnavailable:|maxSurge:|nodes.k8s|replicas:)'
  kubectl get pdb -A -o yaml | grep -E '(^    name:|minAvailable:|expectedPods:|currentHealthy:|desiredHealthy:|disruptionsAllowed:)'
  kubectl get hpa -A -o yaml | grep -E '(^    name:|minReplicas:|maxReplicas:|^      name:    currentReplicas:|    desiredReplicas:)'
}
kubectlnodezone() {
  kubectl get node -o yaml | grep -E '^    name:|topology.kubernetes.io/zone:|labels:|^  metadata:'
}

brew-prune() {
  if [ -e Brewfile ]; then
    for i in $(brew list | grep -v -E $(cat Brewfile | grep -v '^#' | grep -v '^$' | tr -d , | tr -d '"' | awk '{print $2}' | tr "\n" '|' | sed 's,|$,,')) ; do brew uninstall $i ; done
    brew bundle
  fi
}

gg() {
  # GG_GITHUB_MILESTONE=
  # GG_GITHUB_ORG=
  # GG_GITHUB_PROJECT='18'
  GG_GITHUB_LABEL='devops :test_tube:'

  TMP_LOG=$(mktemp)
  case "$1" in
    pr)
      gh label create "$GG_GITHUB_LABEL" --color '#0E8A16' --force || true
      git push
      set -x
      gh pr create --assignee '@me' --draft --fill-first --label $GG_GITHUB_LABEL --milestone $GG_GITHUB_MILESTONE 2>&1 | tee $TMP_LOG
      set +x
      NEW_PR=$(grep "https://github\.com/$GG_GITHUB_ORG/.*/pull/.*" $TMP_LOG | tail -n1)
      gh project item-add $GG_GITHUB_PROJECT --owner $GG_GITHUB_ORG --url $NEW_PR
      test -e $TMP_LOG && rm $TMP_LOG
      gh pr view --web
      ;;
    label)
      gh label create "$GG_GITHUB_LABEL" --color '#0E8A16' --force || true
      gh project item-add $GG_GITHUB_PROJECT --owner $GG_GITHUB_ORG --url $2
      if echo $2 | grep -q '/pull/' ; then
        set -x
        gh pr edit $2 --add-assignee "@me" --add-label $GG_GITHUB_LABEL --milestone $GG_GITHUB_MILESTONE
        gh pr view $2 --web
        set +x
      elif echo $2 | grep -q '/issues/' ; then
        set -x
        gh issue edit $2 --add-assignee "@me" --add-label $GG_GITHUB_LABEL --milestone $GG_GITHUB_MILESTONE
        gh issue view $2 --web
        set +x
      fi
      ;;
    clean)
      OLD_BRANCH=$(git rev-parse --abbrev-ref HEAD)
      DEFAULT_BRANCH=master
      if git branch -a | grep -q 'remotes/origin/main'; then
        DEFAULT_BRANCH=main
      fi
      set -x
      git checkout $DEFAULT_BRANCH
      if [ "$OLD_BRANCH" != "$DEFAULT_BRANCH" ]; then
        git branch -D $OLD_BRANCH
      fi
      git pull --ff-only
      # finally, prune old remote branches
      git fetch origin --prune
      set +x
      ;;
    *)
      cat <<EOF
Usage:
  $0 pr                  Push with 'git' and open PR with 'gh' from current HEAD branch
  $0 label github_url    Tags PR/Issue with my label, milestone and add to GH Project
  $0 clean               Deletes current branch, checkout main/master branch and pull
EOF
      ;;
  esac
}

lint() {
  if [ -z "$1" ]; then
    echo "ERROR: Missing filenames to lint."
    return
  fi
  if [ -e .nvmrc ] && nvm current >/dev/null 2>&1; then
    MY_NVM=$(nvm current | tr -d '\s')
    MY_NVMRC=$(cat .nvmrc | tr -d '\s')
    if [ "$MY_NVM" != "$MY_NVMRC" ]; then
      echo "ERROR: Mismatch node version. Have $MY_NVM want $MY_NVMRC"
      echo "Try:   nvm use"
      return
    fi
  fi
  for i in $@ ; do
    echo "==> $i"
    if echo $i | grep -q -E '\.(js|ts)$' ; then
      set -x
      npx eslint --config .eslintrc.js --fix $i
      set +x
    elif echo $i | grep -q -E '\.(py)$' ; then
      set -x
      black $i
      set +x
    elif echo $i | grep -q -E '\.(tf)$' ; then
      set -x
      terraform fmt $i
      set +x
    fi
  done
}
