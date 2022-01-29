#!/usr/bin/env bash
set -eux

git stash
git checkout johnko
git rebase master
git checkout master
git stash pop
