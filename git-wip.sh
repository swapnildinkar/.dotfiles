#!/usr/bin/env bash

git add -u

if [ "$(git log -1 --pretty=%B)" = "WIP" ]; then
    git commit --amend --no-edit
else
    git commit -m "WIP"
fi
