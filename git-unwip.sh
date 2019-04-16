#!/usr/bin/env bash

if [ "$(git log -1 --pretty=%B)" = "WIP" ]; then
    git pop # defined as an alias, remember!
else
    echo "No work in progress"
fi
