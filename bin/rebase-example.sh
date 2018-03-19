#!/usr/bin/env bash
set -e
set -x
set -u

g stash ; \
g checkout johnko ; g rebase master ; \
g checkout master ; g stash pop
