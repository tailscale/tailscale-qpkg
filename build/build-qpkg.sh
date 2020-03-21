#!/bin/bash

export PATH=$PATH:/usr/share/QDK/bin
export VERSION=${TSTAG:1}

qbuild --create-env Tailscale --build-version $VERSION
cp out/tailscaled-386 /Tailscale/x86/tailscaled
cp out/tailscaled-amd64 /Tailscale/x86_64/tailscaled
# 32-bit ARM?
cp out/tailscaled-arm64 /Tailscale/arm_64/tailscaled

sed -i '/#QPKG_REQUIRE/cQPKG_REQUIRE="QVPN"' /Tailscale/qpkg.cfg 

sed -i '/: ADD START ACTIONS HERE/c\
    $QPKG_ROOT/tailscaled --port 41641 2> /dev/null &\
    echo $! > /var/run/tailscale.pid\
    sleep 3' /Tailscale/shared/Tailscale.sh

sed -i '/: ADD STOP ACTIONS HERE/c\
    ID=$(more /var/run/tailscale.pid)\
    if [ -e /var/run/tailscale.pid ]; then\
        kill -9 $ID\
        rm -f /var/run/tailscale.pid\
    fi' /Tailscale/shared/Tailscale.sh

qbuild --root /Tailscale --build-arch x86 --build-dir /out/pkg
qbuild --root /Tailscale --build-arch x86_64 --build-dir /out/pkg
qbuild --root /Tailscale --build-arch arm_64 --build-dir /out/pkg

chmod -R 777 /out
