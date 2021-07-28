[![Build packages](https://github.com/ivokub/tailscale-qpkg/workflows/Build%20packages/badge.svg?branch=master)](https://github.com/ivokub/tailscale-qpkg/actions/workflows/build.yml)
[![Latest release](https://img.shields.io/github/v/release/ivokub/tailscale-qpkg?sort=semver)](https://github.com/ivokub/tailscale-qpkg/releases/latest)

Tailscale QPKG builder
======================

This repository includes build scripts for building Tailscale client QPKG for
use in QNAP NAS. For common issues see [FAQ](#FAQ)

Attention!
----------

QTS version 5.0.1.2145 is known to break Tailscale installation. Do not upgrade
your QNAP if you do not have secondary access to your device or you may risk
losing access. For details see [issue #46](https://github.com/ivokub/tailscale-qpkg/issues/46).

Build
-----

The build depends on Docker and `make`. All other build dependencies are
downloaded in the Docker containers. To invoke the build, run `make pkg`.
This builds Tailscale QPKG for different platforms and stores them in
**out/pkg**.

By default, Tailscale release v1.12.1 is built. To configure the release number,
set the environment variable `TSTAG` to the release number, e.g.
`TRACK=unstable TSTAG=1.9.134 make pkg`.

Installation
------------

1. Install QVPN package in QNAP App Center to provide `tun` kernel modules.
2. Manually install Tailscale package in QNAP App Center.
3. Open the Tailscale app and proceed with login.

License
-------

This repository is licensed under MIT.
