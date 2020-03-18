#!/usr/bin/env bash

go get -u tailscale.com/cmd/tailscaled
go build -o /out tailscale.com/cmd/tailscaled
