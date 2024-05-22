# Tailscale package for QNAP NAS

QPKG client for Tailscale.

## Tailscale package for QNAP NAS

File issues at: https://github.com/tailscale/tailscale-qpkg/issues

## Installation

See the [QNAP installation guide](https://tailscale.com/kb/1273/qnap) on the Tailscale website.

## Building from source

The source code for the QNAP packages is kept in (Tailscale's main code repository)[https://github.com/tailscale/tailscale]. You can build the packages from source yourself with:

```
git clone https://github.com/tailscale/tailscale.git
cd tailscale
./tool/go run ./cmd/dist build qnap
```

The build depends on Docker. All other build dependencies are downloaded in the Docker containers.

If everything worked you should have a directory called `dist` that contains the QPKG files.

## Precompiled packages

Tailscale also makes precompiled QNAP packages available, supporting a variety of architectures.

- [Stable](https://pkgs.tailscale.com/stable/#qpkgs): stable releases. If you're not sure which track to use, pick this one.
- [Unstable](https://pkgs.tailscale.com/unstable/#qpkgs): the bleeding edge. Pushed early and often. Expect rough edges!

## Credits

Thanks to [@ivokub](https://github.com/ivokub/) for originally creating the Tailscale QPKGs project and transferring it to Tailscale's GitHub org.
