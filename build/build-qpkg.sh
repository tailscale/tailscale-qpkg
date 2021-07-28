#!/bin/bash

mkdir -p /Tailscale/x86
cp /out/tailscaled-386 /Tailscale/x86/tailscaled
cp /out/tailscale-386 /Tailscale/x86/tailscale
cp /out/tailscale-386 /Tailscale/x86/index.cgi

mkdir -p /Tailscale/x86_ce53xx
cp /out/tailscaled-386 /Tailscale/x86_ce53xx/tailscaled
cp /out/tailscale-386 /Tailscale/x86_ce53xx/tailscale
cp /out/tailscale-386 /Tailscale/x86_ce53xx/index.cgi

mkdir -p /Tailscale/x86_64
cp /out/tailscaled-amd64 /Tailscale/x86_64/tailscaled
cp /out/tailscale-amd64 /Tailscale/x86_64/tailscale
cp /out/tailscale-amd64 /Tailscale/x86_64/index.cgi

mkdir -p /Tailscale/arm-x31
cp /out/tailscaled-arm /Tailscale/arm-x31/tailscaled
cp /out/tailscale-arm /Tailscale/arm-x31/tailscale
cp /out/tailscale-arm /Tailscale/arm-x31/index.cgi

mkdir -p /Tailscale/arm-x41
cp /out/tailscaled-arm /Tailscale/arm-x41/tailscaled
cp /out/tailscale-arm /Tailscale/arm-x41/tailscale
cp /out/tailscale-arm /Tailscale/arm-x41/index.cgi

mkdir -p /Tailscale/arm-x19
cp /out/tailscaled-arm /Tailscale/arm-x19/tailscaled
cp /out/tailscale-arm /Tailscale/arm-x19/tailscale
cp /out/tailscale-arm /Tailscale/arm-x19/index.cgi

mkdir -p /Tailscale/arm_64
cp /out/tailscaled-arm64 /Tailscale/arm_64/tailscaled
cp /out/tailscale-arm64 /Tailscale/arm_64/tailscale
cp /out/tailscale-arm64 /Tailscale/arm_64/index.cgi

sed "s/\$QPKG_VER/$TSTAG-$QNAPTAG/g" /Tailscale/qpkg.cfg.in > /Tailscale/qpkg.cfg

qbuild --root /Tailscale --build-arch x86 --build-dir /out/pkg
qbuild --root /Tailscale --build-arch x86_ce53xx --build-dir /out/pkg
qbuild --root /Tailscale --build-arch x86_64 --build-dir /out/pkg
qbuild --root /Tailscale --build-arch arm-x19 --build-dir /out/pkg
qbuild --root /Tailscale --build-arch arm-x31 --build-dir /out/pkg
qbuild --root /Tailscale --build-arch arm-x41 --build-dir /out/pkg
qbuild --root /Tailscale --build-arch arm_64 --build-dir /out/pkg
