#!/usr/bin/env bash

git clone --depth 1 --branch $TSTAG https://github.com/tailscale/tailscale
cd tailscale

for GOARCH in 386 amd64 arm64; do
    export GOARCH
    ./build_dist.sh -o /out/tailscaled-$GOARCH tailscale.com/cmd/tailscaled
    ./build_dist.sh -o /out/tailscale-$GOARCH tailscale.com/cmd/tailscale
done

for GOARM in 5 7; do
    export GOARM
    export GOARCH=arm
    ./build_dist.sh -o /out/tailscaled-armv$GOARM tailscale.com/cmd/tailscaled
    ./build_dist.sh -o /out/tailscale-armv$GOARM tailscale.com/cmd/tailscale
done
