# Tailscale package for QNAP NAS

This repository includes build scripts for building Tailscale client QPKG for
use in QNAP NAS devices.

## Build

The build depends on Docker and `make`. All other build dependencies are
downloaded in the Docker containers. To invoke the build, run
`make build-qdk-container` to build the container and run `make pkg`.
This builds Tailscale QPKG for different platforms and stores them in
**out/pkg**.

To configure the release number from what is in the Makefile,
set the environment variable `TSTAG` to the release number, e.g.
`TRACK=unstable TSTAG=1.33.161 make pkg`.

## Installation

1. Manually install Tailscale package in QNAP App Center.
2. Open the Tailscale app and proceed with login.

## Credits

Thanks to [@ivokub](https://github.com/ivokub/) for creating this
project and transferring it to Tailscale's GitHub org.
