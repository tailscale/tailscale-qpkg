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
downloaded in the Docker containers. To invoke the build, run `make out/pkg`.
This builds Tailscale QPKG for different platforms and stores them in
**out/pkg**.

By default, Tailscale release v1.32.2 is built. To configure the release number,
set the environment variable `TSTAG` to the release number, e.g.
`TSTAG=v1.32.2 make out/pkg`.

How-To Build in Windows
----------------
1. Install ["Windows Subsystem for Linux (WSL)](https://docs.microsoft.com/en-us/windows/wsl/install).
2. Run WSL: `wsl.exe`
3. Run `sudo apt install docker.io build-essential -y`
4. `git clone https://github.com/ivokub/tailscale-qpkg.git`
5. `sudo dockerd`
6. `cd tailscale-qpkg/`
7. `sudo make out/pkg`
8. Packages are located at `%USERPROFILE%\tailscale-qpkg\out\pkg`

Installation
------------

1. Manually install Tailscale package in QNAP App Center.
2. SSH into your QNAP. If instead of command line shell you see a list of options, choose Q to open shell.
3. Get system volume path: `getcfg SHARE_DEF defVolMP -f /etc/config/def_share.info` (e.g. `/share/CE_CACHEDEV1_DATA/`).
4. Go to Tailscale package directory by using the path you got above: `cd /share/CE_CACHEDEV1_DATA/.qpkg/Tailscale`
5. Authorize your client: `./tailscale -socket var/run/tailscale/tailscaled.sock up`

Updating
--------

When Tailscale package is already installed, then it is sufficient to install
only a new version of Tailscale package in QNAP App Center. The service will
restart automatically and use current configuration.

To build new package manually, rerun the commands for corresponding target
(UNIX or Windows) in the updated repository.

FAQ
---

* Installation completes successfully, but Tailscale service does not start.

  Try installing QVPN package in the App Centre. Newer QTS versions contain the
  tun kernel module required for Wireguard but older releases don't. QVPN has
  the module prepackaged.

* Tailscale service starts but I am unable to connect to device using Tailscale IP.

  Allow incoming connections from 100.0.0.0/8 network in the firewall.

License
-------

This repository is licensed under MIT.
