#!/usr/bin/env bash

alias history='history -i'
alias tf="terraform"
alias yless="jless --yaml"

########################################

if [[ -x /usr/bin/dircolors || -e /Users ]]; then
  if [[ -x /usr/bin/dircolors ]]; then
    if test -r ~/.dircolors; then
      eval "$(dircolors -b ~/.dircolors)"
    else
      eval "$(dircolors -b)"
    fi
  fi
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

########################################
# macOS aliases
if [[ -e /Users ]]; then
  alias cdoe="code"
  alias iftop="sudo /usr/local/sbin/iftop -nBP"
  alias ls="ls -1G"
  alias pmgetprevent="pmset -g | grep prevent"

  ########################################
  # macOS functions
  dff() {
    df -h | grep -v -E '(devfs|auto_home)' | tr -d '%' | sort -r -k5 | awk '$5 > 24 {print $1,$5"%","=",$3,"/",$2,$9,$4}' | column -t
  }
  free() {
    MEMORY_TOTAL=$(sysctl hw.memsize | awk '{print $NF/1024/1024/1024}')
    top -l 1 -s 0 | grep PhysMem | sed 's, (.*),,' | sed "s/\.$/, ${MEMORY_TOTAL}G total./"
  }
  ppgrep() {
    # Usage: ppgrep bash
    pgrep "$@" | xargs ps
  }
else
  ########################################
  # Linux aliases
  # Add an "alert" alias for long running commands.  Use like so:
  #   sleep 10; alert
  alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

  alias dd="sudo /bin/dd status=progress"
  alias iftop="sudo /usr/sbin/iftop -nBP"
  alias ls='ls --color=auto'
  alias rehash='hash -r'
  alias zio="sudo zpool iostat"
  alias zl="sudo zfs list -oname,lused,usedds,usedchild,usedsnap,used,avail,refer,mountpoint,mounted,canmount"
  alias zll="sudo zfs list -oname,dedup,compress,compressratio,checksum,sync,quota,copies,atime,devices,exec,rdonly,setuid,xattr,acltype,aclinherit"
  alias zls="sudo zfs list -t snap -oname,used,avail,refer"
  alias zpl="sudo zpool list -oname,size,alloc,free,cap,dedup,health,frag,ashift,freeing,expandsz,expand,replace,readonly,altroot"
  alias zs="sudo zpool status"

  ########################################
  # Linux functions
  copypubkey2clipboard() {
    for i in ~/.ssh/id_*.pub; do
      test -e "${i}" && cat "${i}" | xsel --clipboard
    done
  }
  ppgrep() {
    # Usage: ppgrep bash
    pgrep "$@" | xargs --no-run-if-empty ps fp
  }
  whatismydhcpserver() {
    for i in $(ps aux | grep -o '[/]var/lib/NetworkManager/\S*.lease') \
      $(ps aux | grep -o '[/]var/lib/dhcp/dhclient\S*.leases'); do
      test -f "${i}" && grep "dhcp-server-identifier" "${i}"
    done
  }
fi

########################################
# some more ls aliases
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'

########################################
# rsync aliases
alias rsynca="rsync -viaP --exclude-from=\${HOME}/.rsync_exclude"
alias rsyncc="rsync -virchlmP --exclude-from=\${HOME}/.rsync_exclude"
alias rsynct="rsync -virthlmP --exclude-from=\${HOME}/.rsync_exclude"

########################################
# git aliases
alias g="git --no-pager"
alias gd="git d"
alias gs="git s"
alias gpush="git push"
if type git &>/dev/null; then
  # Use Git’s colored diff when available
  difff() {
    if [[ -z ${1} ]]; then
      git --no-pager diff --ignore-space-change
    elif [[ -z ${2} ]]; then
      git --no-pager diff --ignore-space-change "$@"
    else
      git --no-pager diff --no-index --ignore-space-change "$@"
    fi
  }
fi
allow-git-remote() {
  if [[ ! -e ~/.allowed_git_remote ]]; then
    touch ~/.allowed_git_remote
  fi
}
deny-git-remote() {
  if [[ -e ~/.allowed_git_remote ]]; then
    rm ~/.allowed_git_remote
  fi
}
allow-git-sign() {
  if [[ ! -e ~/.allowed_git_sign ]]; then
    touch ~/.allowed_git_sign
  fi
}
deny-git-sign() {
  if [[ ! -e ~/.allowed_git_sign ]]; then
    rm ~/.allowed_git_sign
  fi
}

########################################

aws-ssm() {
  ec2name="$1"
  aws ssm start-session --target $(aws ec2 describe-instances --filters '[{"Name":"tag:Name","Values":["'$ec2name'"]},{"Name":"instance-state-name","Values":["running"]}]' --query "Reservations[0].Instances[0].InstanceId" --output text)
}
fetch_cert() {
  echo | openssl s_client -servername "$1" -connect "$1:443" 2>/dev/null | openssl x509 -text
}
firstlastline() {
  head -n1 "${1}"
  tail -n1 "${1}"
}
# Usage: json '{"foo":42}' or echo '{"foo":42}' | json
# Syntax-highlight JSON strings or files
json() {
  if [[ -t 0 ]]; then
    # has argument
    python3 -m json.tool <<<"$*" | pygmentize -l javascript
  else
    # is piped
    python3 -m json.tool | pygmentize -l javascript
  fi
}
t() {
  tmux attach || tmux
}

########################################
# docker aliases
if type docker &>/dev/null; then
  unalias docker &>/dev/null || true
else
  if type podman &>/dev/null; then
    alias docker=podman
  fi
fi
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

########################################

dockprom() {
  if [[ -d ./code ]]; then
    SCRIPT_PATH=$(find ./code -maxdepth 3 -type f -name dockprom.sh)
    if [[ -n $SCRIPT_PATH ]]; then
      cd "$(dirname "$SCRIPT_PATH")" || return 1
      ./dockprom.sh "$@"
      cd - || return 1
    fi
  fi
}

########################################

gg() {
  # GG_GITHUB_MILESTONE="--milestone"
  # GG_GITHUB_ORG=
  # GG_GITHUB_PROJECT='18'
  GG_GITHUB_LABEL='devops :test_tube:'
  GG_WORKDIR=~/code/cursor

  TMP_LOG=$(mktemp)
  case "$1" in
    pr)
      gh label create "$GG_GITHUB_LABEL" --color '#0E8A16' --force || true
      git push
      set -x
      # shellcheck disable=SC2086
      gh pr create --assignee '@me' --draft --fill-first --label $GG_GITHUB_LABEL $GG_GITHUB_MILESTONE 2>&1 | tee "$TMP_LOG"
      set +x
      NEW_PR=$(grep "https://github\.com/$GG_GITHUB_ORG/.*/pull/.*" "$TMP_LOG" | tail -n1)
      if [[ -n $GG_GITHUB_PROJECT ]]; then
        gh project item-add "$GG_GITHUB_PROJECT" --owner "$GG_GITHUB_ORG" --url "$NEW_PR"
      fi
      test -e "$TMP_LOG" && rm "$TMP_LOG"
      gh pr view --web
      ;;
    label)
      gh label create "$GG_GITHUB_LABEL" --color '#0E8A16' --force || true
      if [[ -n $GG_GITHUB_PROJECT ]]; then
        gh project item-add "$GG_GITHUB_PROJECT" --owner "$GG_GITHUB_ORG" --url "$2"
      fi
      if echo "$2" | grep -q '/pull/'; then
        set -x
        # shellcheck disable=SC2086
        gh pr edit "$2" --add-assignee "@me" --add-label $GG_GITHUB_LABEL $GG_GITHUB_MILESTONE
        gh pr view "$2" --web
        set +x
      elif echo "$2" | grep -q '/issues/'; then
        set -x
        # shellcheck disable=SC2086
        gh issue edit "$2" --add-assignee "@me" --add-label $GG_GITHUB_LABEL $GG_GITHUB_MILESTONE
        gh issue view "$2" --web
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
      git checkout "$DEFAULT_BRANCH"
      if [[ $OLD_BRANCH != "$DEFAULT_BRANCH" ]]; then
        git branch -D "$OLD_BRANCH"
      fi
      git pull --ff-only
      # finally, prune old remote branches
      git fetch origin --prune
      set +x
      ;;
    renovate)
      RENOVATE_WORKFLOW_NAME=$(gh workflow list | grep -v config | grep -i renovate | awk '{print $1}')
      if [[ -n $RENOVATE_WORKFLOW_NAME ]]; then
        gh workflow run "$RENOVATE_WORKFLOW_NAME"
      else
        gh workflow list >/dev/null 2>&1 || echo "ERROR: Cannot list workflows. Try:    gh auth refresh --scopes workflow"
      fi
      ;;
    worktree)
      pushd "$GG_WORKDIR"
      LOCAL_REPO="$2"
      if [[ ! -e $LOCAL_REPO && ! -e "$LOCAL_REPO/.git" ]]; then
        git clone "git@github.com:$GG_GITHUB_ORG/$LOCAL_REPO.git" "$LOCAL_REPO"
      fi
      if [[ -e $LOCAL_REPO && -e "$LOCAL_REPO/.git" ]]; then
        SAFE_BRANCH=$(echo "$3" | sed 's/[^a-zA-Z0-9-]/-/g' | cut -c1-50)

        pushd "$LOCAL_REPO"
        DEFAULT_BRANCH=master
        if git branch -a | grep -q 'remotes/origin/main'; then
          DEFAULT_BRANCH=main
        fi
        git fetch origin "$DEFAULT_BRANCH"
        # add new branch or checkout existing
        git worktree add -b "$SAFE_BRANCH" ../"$LOCAL_REPO.worktrees/$SAFE_BRANCH" "origin/$DEFAULT_BRANCH" || git worktree add ../"$LOCAL_REPO.worktrees/$SAFE_BRANCH" "$SAFE_BRANCH"

        pushd ../"$LOCAL_REPO.worktrees/$SAFE_BRANCH"
        echo "Opening code and cursor (if possible)"
        if type code &>/dev/null; then
          code .
        fi
        if type cursor &>/dev/null; then
          cursor .
        fi
      fi
      ;;
    vsk8s)
      if [[ -e ~/.aws/config ]]; then
        if ! grep -q cursor ~/.aws/config; then
          echo "ERROR: AWS Profile 'cursor' was not found in ~/.aws/config"
        else
          AWS_VAULT_PROMPT=ykman aws-vault export cursor | awk '{print "export "$0}' >~/.aws_temp_credentials_secret
        fi
        if [[ -e ~/kubeconfig/cursor.config ]]; then
          export KUBECONFIG=~/kubeconfig/cursor.config
        else
          echo "ERROR: kube config was not found at ~/kubeconfig/cursor.config"
        fi
        if [[ -e ~/.aws_temp_credentials_secret ]]; then
          set +x
          source ~/.aws_temp_credentials_secret
        fi
      fi
      if [[ -z $CODE_EDITOR ]]; then
        OPEN_EDITOR=code
      else
        OPEN_EDITOR=$CODE_EDITOR
      fi
      echo "Opening $OPEN_EDITOR"
      $OPEN_EDITOR
      ;;
    *)
      cat <<EOF
Usage:
  $0 pr                     Push with 'git' and open PR with 'gh' from current HEAD branch
  $0 label github_url       Tags PR/Issue with my label, milestone and add to GH Project
  $0 clean                  Deletes current branch, checkout main/master branch and pull
  $0 worktree repo branch   Created worktree from local repo and creates branch and opens cursor
  $0 vsk8s                  Open VSCode with k8s config
EOF
      ;;
  esac
}
if [[ -n $VSCODE_INJECTION && $VSCODE_INJECTION == "1" || -n $VSCODE_GIT_IPC_HANDLE || -n $VSCODE_NONCE ]]; then
  if set | grep -v grep | grep -i ASKPASS | grep -q -E '/(Visual Studio Code.app)/'; then
    DETECTED=code
  fi
  if [[ -n $CURSOR_TRACE_ID ]]; then
    DETECTED=cursor
  else
    if set | grep -v grep | grep -i ASKPASS | grep -q -E '/(Cursor.app|.cursor-server)/'; then
      DETECTED=cursor
    fi
  fi
fi
if [[ $DETECTED == "code" || $DETECTED == "cursor" ]]; then
  # only load ~/.aws_temp_credentials_secret if vscode/cursor detected to avoid polluting terminal
  if [[ -e ~/kubeconfig/cursor.config ]]; then
    export KUBECONFIG=~/kubeconfig/cursor.config
  fi
  if [[ -e ~/.aws_temp_credentials_secret ]]; then
    set +x
    source ~/.aws_temp_credentials_secret
  fi
fi

########################################
# k8s/helm aliases
alias k="kubectl"
alias ka="kubectl -o wide"
alias kk="kubectl -n kube-system"
kubectldryrun() {
  kubectl apply --dry-run=client -f -
}
kubectlnodeupgraderollstrategy() {
  kubectl get deployment -A -o yaml | grep -E '(^    name:|maxUnavailable:|maxSurge:|nodes.k8s|replicas:)'
  kubectl get pdb -A -o yaml | grep -E '(^    name:|minAvailable:|expectedPods:|currentHealthy:|desiredHealthy:|disruptionsAllowed:)'
  kubectl get hpa -A -o yaml | grep -E '(^    name:|minReplicas:|maxReplicas:|^      name:    currentReplicas:|    desiredReplicas:)'
}
kubectlnodeupgradestuckpods() {
  for i in $(kubectl get node | grep SchedulingDisabled | awk -F. '{print $1}'); do kubectl get pod -A -o wide | grep "$i" | grep -v Completed; done
}
kubectlpermissions() {
  kubectl auth can-i --list --namespace "$1"
}
kubectlnodezone() {
  kubectl get node -o yaml | grep -E '^    name:|topology.kubernetes.io/zone:|labels:|^  metadata:'
}
helmdryrun() {
  helm upgrade --atomic --dry-run -f "$1" -n"$2" "$3" .
}
helmtemplate() {
  helm template --atomic -f "$1" -f ~/test-secrets-template.yaml -n"$2" "$3" .
}
helmvalidate() {
  helm template --atomic -f "$1" -f ~/test-secrets-template.yaml -n"$2" "$3" . | kubectl apply --dry-run=client -f -
}

########################################

lint() {
  # Usage:
  #     lint "$(git diff --name-only)"
  #     git diff --name-only | lint
  FILES=$@
  if [[ -z $1 ]]; then
    FILES=$(cat </dev/stdin)
    if [[ -z $FILES ]]; then
      echo "ERROR: Missing filenames to lint."
      return
    fi
  fi
  if [[ -e .nvmrc ]] && nvm current &>/dev/null; then
    MY_NVM=$(nvm current | tr -d '\s')
    MY_NVMRC=$(cat .nvmrc | tr -d '\s')
    if [[ $MY_NVM != "$MY_NVMRC" ]]; then
      echo "ERROR: Mismatch node version. Have $MY_NVM want $MY_NVMRC"
      echo "Try:   nvm use"
      return
    fi
  fi
  while IFS= read -r i; do
    echo "==> $i"
    if echo "$i" | grep -q -E '\.(js|ts)$'; then
      set -x
      npx eslint --config .eslintrc.js --fix "$i"
      set +x
    elif echo "$i" | grep -q -E '\.(py)$'; then
      set -x
      black "$i"
      set +x
    elif echo "$i" | grep -q -E '\.(tf)$'; then
      set -x
      terraform fmt "$i"
      set +x
    fi
  done <<<"$FILES"
}

########################################

nosleep() {
  NO_SLEEP_VIDEO_FILE=$(find /Library/Application\ Support/com.apple.idleassetsd/Customer/4KSDR240FPS -type f -name '*.mov' | sort -R | tail -n 1)
  if [[ -z $NO_SLEEP_VIDEO_FILE ]]; then
    NO_SLEEP_VIDEO_FILE="/System/Library/CoreServices/NotificationCenter.app/Contents/Resources/mac_widgets-edu_full.mov"
  fi
  export NO_SLEEP_VIDEO_FILE
  envsubst <~/.nosleep/video.html.example >~/.nosleep/video.html
  envsubst <~/.nosleep/clock.html.example >~/.nosleep/clock.html
  if ls -1 /Applications | grep -q -i brave; then
    BROWSER_APP="Brave Browser"
  else
    BROWSER_APP="Safari"
  fi
  # open -a "$BROWSER_APP" ~/.nosleep/video.html
  open -a "$BROWSER_APP" ~/.nosleep/clock.html
}

########################################
# repos aliases
repos-fetchorigin() {
  # shellcheck disable=SC2044
  for i in $(find . -mindepth 1 -maxdepth 1 -type d); do
    if [[ -e "${i}/.git" ]]; then
      pushd "${i}" >/dev/null || return
      localbranch=$(git branch --show-current)
      local branch=$localbranch
      localremoteorigin=$(git remote | grep origin | head -n1)
      local remoteorigin=$localremoteorigin
      localremotebranch=$(git branch -va | grep "remotes/${remoteorigin}/HEAD" | awk '{print $NF}' | sed "s;${remoteorigin}/;;")
      local remotebranch=$localremotebranch
      if [[ -z ${remoteorigin} ]]; then
        echo "==> ${__YELLOW}${i} ${__CYAN}* ${branch} ${__RED}* No remotes.${__RESET}"
      else
        local cmdfetch="git fetch ${remoteorigin} ${remotebranch}"
        echo "==> ${__YELLOW}${i} ${__CYAN}* ${branch} ${__GREEN}* Running: ${__PURPLE}${cmdfetch}${__RESET}"
        # shellcheck disable=SC2086
        eval ${cmdfetch} 2>&1 | awk '{print "        "$0}'
        if [[ ${remotebranch} == "${branch}" ]]; then
          local cmdmerge="git merge --ff-only ${remoteorigin}/${remotebranch}"
          echo "    ${__GREEN}* Running: ${__PURPLE}${cmdmerge}${__RESET}"
          # shellcheck disable=SC2086
          eval ${cmdmerge} 2>&1 | awk '{print "        "$0}'
        fi
      fi
      popd >/dev/null || return
    fi
  done
}
repos-branches() {
  # shellcheck disable=SC2044
  for i in $(find . -mindepth 1 -maxdepth 1 -type d); do
    if [[ -e "${i}/.git" ]]; then
      pushd "${i}" >/dev/null || return
      local_branch=$(git branch --show-current)
      local branch=$local_branch
      echo "==> ${__YELLOW}${i} ${__CYAN}* ${branch}${__RESET}"
      popd >/dev/null || return
    fi
  done
}
repos-renovatebranches() {
  # shellcheck disable=SC2044
  for i in $(find . -mindepth 1 -maxdepth 1 -type d); do
    if [[ -e "${i}/.git" ]]; then
      pushd "${i}" >/dev/null || return
      echo "==> ${__YELLOW}${i}${__RESET}"
      git remote prune origin
      git branch -a | grep renovate || true
      popd >/dev/null || return
    fi
  done
}
repos-renovaterun() {
  # shellcheck disable=SC2044
  for i in $(find . -mindepth 1 -maxdepth 1 -type d); do
    if [[ -e "${i}/.git" ]]; then
      pushd "${i}" >/dev/null || return
      echo "==> ${__YELLOW}${i}${__RESET}"
      gg renovate || true
      popd >/dev/null || return
    fi
  done
}
repos-status() {
  # shellcheck disable=SC2044
  for i in $(find . -mindepth 1 -maxdepth 1 -type d); do
    if [[ -e "${i}/.git" ]]; then
      pushd "${i}" >/dev/null || return
      echo "==> ${__YELLOW}${i}${__RESET}"
      git status -s
      popd >/dev/null || return
    fi
  done
}
repos-tmptmp() {
  # shellcheck disable=SC2044
  for i in $(find . -mindepth 1 -maxdepth 1 -type d); do
    if [[ -e "${i}/.git" ]]; then
      pushd "${i}" >/dev/null || return
      echo "==> ${__YELLOW}${i}${__RESET}"
      git branch -a | grep tmp/tmp || true
      popd >/dev/null || return
    fi
  done
}
repos-updatemaster() {
  TMP_BRANCH=tmp/tmp$(date +%s)
  # shellcheck disable=SC2044
  for i in $(find . -mindepth 1 -maxdepth 1 -type d -not -name '*.*'); do
    if [[ -e "${i}/.git" ]]; then
      pushd "${i}" >/dev/null || return
      echo "==> ${__YELLOW}${i}${__RESET}"
      DEFAULT_BRANCH=master
      if git branch -a | grep -q 'remotes/origin/main'; then
        DEFAULT_BRANCH=main
      fi
      git checkout -b "$TMP_BRANCH"
      git fetch origin "$DEFAULT_BRANCH"
      git branch -D "$DEFAULT_BRANCH" || true
      git checkout -b "$DEFAULT_BRANCH" --track "origin/$DEFAULT_BRANCH"
      git branch -D "$TMP_BRANCH"
      popd >/dev/null || return
    fi
  done
}

########################################
# switchaudio aliases
audio() {
  FUZZY_MATCH="$1"
  LIST_CMD=(SwitchAudioSource -a)
  GREP_CMD=(grep -v -i -E 'microphone|samsung|ultrafine|u32j59x')
  if type SwitchAudioSource &>/dev/null; then
    # shellcheck disable=SC2128
    FOUND_AUDIO_DEVICE=$($LIST_CMD | $GREP_CMD | grep -i "$FUZZY_MATCH" | head -n 1)
    if [[ -n $FOUND_AUDIO_DEVICE ]]; then
      SwitchAudioSource -s "$FOUND_AUDIO_DEVICE"
    else
      # shellcheck disable=SC2128
      $LIST_CMD | $GREP_CMD
    fi
  fi
}
vol() {
  for i in $(find "$HOME/.osascripts" -type f -name 'volume-[0-9][0-9].scpt' | sort); do
    VOLUME_PERCENT=$(echo "$i" | grep -o -E '[0-9]+')
    echo -n "❓ Set volume to $VOLUME_PERCENT ...?"
    read
    osascript "$i"
    echo -n "$VOLUME_PERCENT ✅"
    echo
  done
}

########################################
# vagrant aliases
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
