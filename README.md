[![Build packages](https://github.com/ivokub/tailscale-qpkg/workflows/Build%20packages/badge.svg?branch=master)](https://github.com/ivokub/tailscale-qpkg/actions/workflows/build.yml)
[![Latest release](https://img.shields.io/github/v/release/ivokub/tailscale-qpkg?sort=semver)](https://github.com/ivokub/tailscale-qpkg/releases/latest)

Tailscale QPKG builder
======================

This repository includes build scripts for building Tailscale client QPKG for
use in QNAP NAS.

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

By default, Tailscale release v1.30.2 is built. To configure the release number,
set the environment variable `TSTAG` to the release number, e.g.
`TSTAG=v1.30.2 make out/pkg`.

How-To Build in Windows
----------------
1. Install "Windows Subsystem for Linux (WSL) https://docs.microsoft.com/en-us/windows/wsl/install"
  1a. Quick Start WSL by entering this command in an administrator PowerShell or Windows Command Prompt and then restarting your machine `wsl --install`
2. Install Windows Terminal https://aka.ms/terminal
3. From Windows Command Prompt or PowerShell, you can open your default Linux distribution inside your current command line, by entering: `wsl.exe`
4. When in WSL run `sudo apt install docker.io build-essential -y`
5. `git clone https://github.com/ivokub/tailscale-qpkg.git`
6. `sudo dockerd` (then open a new linux session to be able to run next line, if you ctrl-c the service stops)
7. `cd tailscale-qpkg/`
9. `sudo make out/pkg`
10. You can find the files if you do "Win+R" command and paste `%USERPROFILE%\tailscale-qpkg\out\pkg`

Installation
------------

1. Manually install Tailscale package in QNAP App Center.
2. SSH into your QNAP. If instead of command line shell you see a list of options, choose Q to open shell.
3. Get system volume path: `getcfg SHARE_DEF defVolMP -f /etc/config/def_share.info` (e.g. `/share/CE_CACHEDEV1_DATA/`).
4. Go to Tailscale package directory by using the path you got above: `cd /share/CE_CACHEDEV1_DATA/.qpkg/Tailscale`
5. Authorize your client: `./tailscale -socket var/run/tailscale/tailscaled.sock up`

License
-------

This repository is licensed under MIT.
