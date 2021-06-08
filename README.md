[![Build packages](https://github.com/ivokub/tailscale-qpkg/workflows/Build%20packages/badge.svg?branch=master)](https://github.com/ivokub/tailscale-qpkg/actions/workflows/build.yml)
[![Latest release](https://img.shields.io/github/v/release/ivokub/tailscale-qpkg?sort=semver)](https://github.com/ivokub/tailscale-qpkg/releases/latest)

Tailscale QPKG builder
======================

This repository includes build scripts for building Tailscale client QPKG for
use in QNAP NAS.

Build
-----

The build depends on Docker and `make`. All other build dependencies are
downloaded in the Docker containers. To invoke the build, run `make out/pkg`.
This builds Tailscale QPKG for different platforms and stores them in
**out/pkg**.

By default, Tailscale release v1.8.7 is built. To configure the release number,
set the environment variable `TSTAG` to the release number, e.g.
`TSTAG=v1.8.7 make out/pkg`.

Installation
------------

1. Install QVPN package in QNAP App Center to provide `tun` kernel modules.
2. Manually install Tailscale package in QNAP App Center.
3. SSH into your QNAP
4. Get system volume path: `getcfg SHARE_DEF defVolMP -f /etc/config/def_share.info` (e.g. `/share/CE_CACHEDEV1_DATA/`).
5. Go to Tailscale package directory: `cd /share/CE_CACHEDEV1_DATA/.qpkg/Tailscale`
6. Authorize your client: `./tailscale -socket var/run/tailscale/tailscaled.sock up`

License
-------

This repository is licensed under MIT.
