if [ -e /root/.git2 ]; then
    cd /root
    cp -a .git2 .git
    git reset --hard
    rm -r .git
    source .profile
else
    [ -e /root/.bashrc2 ] && source /root/.bashrc2
fi
