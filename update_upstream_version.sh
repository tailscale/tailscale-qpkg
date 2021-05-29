#!/usr/bin/env bash

if [ -z "${TSTAG}" ]; then
    TSTAG=$(curl https://api.github.com/repos/tailscale/tailscale/tags -s | jq '.[0].name' -r)
fi

CURRENT=$(cat upstream_version | sed "s/\./\\\./g")

sed -i "s/$CURRENT/$TSTAG/g" Makefile README.md upstream_version
