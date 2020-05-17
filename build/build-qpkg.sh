#!/bin/bash

export PATH=$PATH:/usr/share/QDK/bin
export VERSION=${TSTAG:1}

qbuild --create-env Tailscale --build-version $VERSION
cp out/tailscaled-386 /Tailscale/x86/tailscaled
cp out/tailscale-386 /Tailscale/x86/tailscale
cp out/tailscaled-amd64 /Tailscale/x86_64/tailscaled
cp out/tailscale-amd64 /Tailscale/x86_64/tailscale
# 32-bit ARM?
cp out/tailscaled-arm64 /Tailscale/arm_64/tailscaled
cp out/tailscale-arm64 /Tailscale/arm_64/tailscale

mkdir -p /Tailscale/shared/var/run/tailscale
mkdir -p /Tailscale/shared/var/lib/tailscale

sed -i '/#QPKG_REQUIRE/cQPKG_REQUIRE="QVPN"' /Tailscale/qpkg.cfg 

sed -i '/: ADD START ACTIONS HERE/c\
    $QPKG_ROOT/tailscaled --port 41641 --state=$QPKG_ROOT/var/lib/tailscale/tailscaled.state --socket=$QPKG_ROOT/var/run/tailscale/tailscaled.sock 2> /dev/null &\
    echo $! > $QPKG_ROOT/var/run/tailscale/tailscale.pid\
    sleep 3' /Tailscale/shared/Tailscale.sh

sed -i '/: ADD STOP ACTIONS HERE/c\
    ID=$(more $QPKG_ROOT/var/run/tailscale/tailscale.pid)\
    if [ -e $QPKG_ROOT/var/run/tailscale/tailscale.pid ]; then\
        kill -9 $ID\
        rm -f $QPKG_ROOT/var/run/tailscale/tailscale.pid\
    fi' /Tailscale/shared/Tailscale.sh

qbuild --root /Tailscale --build-arch x86 --build-dir /out/pkg
qbuild --root /Tailscale --build-arch x86_64 --build-dir /out/pkg
qbuild --root /Tailscale --build-arch arm_64 --build-dir /out/pkg

chmod -R 777 /out
