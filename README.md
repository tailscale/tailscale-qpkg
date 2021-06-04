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

By default, Tailscale release v1.8.6 is built. To configure the release number,
set the environment variable `TSTAG` to the release number, e.g.
`TSTAG=v1.8.6 make out/pkg`.

Installation
------------

1. Install QVPN package in QNAP App Center to provide `tun` kernel modules.
2. QNAP package build example "Ubuntu on Windows (WSL) https://docs.microsoft.com/en-us/windows/wsl/install-win10 "
  2b. sudo apt install docker.io
  2c. git clone https://github.com/ivokub/tailscale-qpkg.git
  2d. cd tailscale-qpkg/
  2e. dockerd (then open a new windows to be able to run next line if you ctrl-c service stops)
  2f. sudo make out/pkg
3. When make is done get the correct package fropm \tailscale-qpkg\out\pkg\ folder
4. Manually install Tailscale package in QNAP App Center.
4. SSH into your QNAP
5. Get system volume path: `getcfg SHARE_DEF defVolMP -f /etc/config/def_share.info` (e.g. `/share/CE_CACHEDEV1_DATA/`).
6. Go to Tailscale package directory: `cd /share/CE_CACHEDEV1_DATA/.qpkg/Tailscale`
7. Authorize your client: `./tailscale -socket var/run/tailscale/tailscaled.sock up`

License
-------

This repository is licensed under MIT.
