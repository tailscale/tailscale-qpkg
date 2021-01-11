#!/usr/bin/env bash

export GO111MODULE=on
go get -u tailscale.com@$TSTAG
cd /go/pkg/mod/tailscale.com@$TSTAG
go mod tidy

for GOARCH in 386 amd64 arm64; do
    export GOARCH
    go build -o /out/tailscaled-$GOARCH tailscale.com/cmd/tailscaled
    go build -o /out/tailscale-$GOARCH tailscale.com/cmd/tailscale
done

for GOARM in 5 7; do
    export GOARM
    export GOARCH=arm
    go build -o /out/tailscaled-armv$GOARM tailscale.com/cmd/tailscaled
    go build -o /out/tailscale-armv$GOARM tailscale.com/cmd/tailscale
done
