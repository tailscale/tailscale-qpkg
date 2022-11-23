#!/usr/bin/env bash

set -e

mkdir -p out/tar
mkdir -p out/extracted
mkdir -p "out/tailscale-${TSTAG}"
for ARCH in 386 amd64 arm arm64; do
    if [[ -e  "out/tailscale-${TSTAG}/tailscale-${ARCH}" ]]; then
        echo "out/tailscale-${TSTAG}/tailscale-${ARCH} already exists; skipping fetch"
        continue
    fi
    echo "Fetching tailscale_${TSTAG}_${ARCH}.tgz"
    wget "https://pkgs.tailscale.com/${TRACK}/tailscale_${TSTAG}_${ARCH}.tgz" -O "out/tar/tailscale_${TSTAG}_${ARCH}.tgz"
    tar xvzf "out/tar/tailscale_${TSTAG}_${ARCH}.tgz" -C "out/extracted"
    mv "out/extracted/tailscale_${TSTAG}_${ARCH}/tailscale" "out/tailscale-${TSTAG}/tailscale-${ARCH}"
    mv "out/extracted/tailscale_${TSTAG}_${ARCH}/tailscaled" "out/tailscale-${TSTAG}/tailscaled-${ARCH}"
done
rm -rf "out/tar"
rm -rf "out/extracted"
