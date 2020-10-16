TSTAG ?= v0.97.0

.PHONY: build-tailscaled-container
build-tailscaled-container:
	docker build -f build/Dockerfile.build -t tailscale-qnap-builder:latest build/

.PHONY: out/tailscaled
out/tailscaled: build-tailscaled-container
	docker run --rm -v ${CURDIR}/out:/out -e TSTAG=${TSTAG} tailscale-qnap-builder

.PHONY: build-qdk-container
build-qdk-container:
	docker build -f build/Dockerfile.qpkg -t qdk:latest build/

.PHONY: out/pkg
out/pkg: build-qdk-container out/tailscaled
	docker run --rm -v ${CURDIR}/out:/out -e TSTAG=${TSTAG} qdk:latest

.PHONY: clean
clean:
	rm -rf out/pkg
	rm -f out/tailscaled-amd64 out/tailscaled-arm64 out/tailscaled-386 out/tailscaled-armv5 out/tailscaled-armv6 out/tailscaled-armv7
	rm -f out/tailscale-amd64 out/tailscale-arm64 out/tailscale-386 out/tailscale-armv5 out/tailscale-armv6 out/tailscale-armv7
