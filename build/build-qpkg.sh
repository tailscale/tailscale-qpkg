#!/bin/bash

mkdir -p /Tailscale/x86
cp /out/tailscaled-386 /Tailscale/x86/tailscaled
cp /out/tailscale-386 /Tailscale/x86/tailscale

mkdir -p /Tailscale/x86_ce53xx
cp /out/tailscaled-386 /Tailscale/x86_ce53xx/tailscaled
cp /out/tailscale-386 /Tailscale/x86_ce53xx/tailscale

mkdir -p /Tailscale/x86_64
cp /out/tailscaled-amd64 /Tailscale/x86_64/tailscaled
cp /out/tailscale-amd64 /Tailscale/x86_64/tailscale

mkdir -p /Tailscale/arm-x31
cp /out/tailscaled-arm /Tailscale/arm-x31/tailscaled
cp /out/tailscale-arm /Tailscale/arm-x31/tailscale

mkdir -p /Tailscale/arm-x41
cp /out/tailscaled-arm /Tailscale/arm-x41/tailscaled
cp /out/tailscale-arm /Tailscale/arm-x41/tailscale

mkdir -p /Tailscale/arm-x19
cp /out/tailscaled-arm /Tailscale/arm-x19/tailscaled
cp /out/tailscale-arm /Tailscale/arm-x19/tailscale

mkdir -p /Tailscale/arm_64
cp /out/tailscaled-arm64 /Tailscale/arm_64/tailscaled
cp /out/tailscale-arm64 /Tailscale/arm_64/tailscale

sed "s/\$QPKG_VER/$TSTAG-$QNAPTAG/g" /Tailscale/qpkg.cfg.in > /Tailscale/qpkg.cfg

qbuild --root /Tailscale --build-arch x86 --build-dir /out/pkg
qbuild --root /Tailscale --build-arch x86_ce53xx --build-dir /out/pkg
qbuild --root /Tailscale --build-arch x86_64 --build-dir /out/pkg
qbuild --root /Tailscale --build-arch arm-x31 --build-dir /out/pkg
qbuild --root /Tailscale --build-arch arm-x41 --build-dir /out/pkg
qbuild --root /Tailscale --build-arch arm_64 --build-dir /out/pkg

# arm-x19 NAS don't support QTS5 anyway, so let's downgrade the requirements
# and build this one with QTS 4 support.
sed "s/\$QPKG_VER/$TSTAG-$QNAPTAG/g" /Tailscale/qpkg-QTS4.cfg.in >/Tailscale/qpkg.cfg
qbuild --root /Tailscale --build-arch arm-x19 --build-dir /out/pkg
