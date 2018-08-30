#!/usr/bin/env bash
set -e
set -x
set -u

git stash
git checkout johnko
git rebase master
git checkout master
git stash pop
