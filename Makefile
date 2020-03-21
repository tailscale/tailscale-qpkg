TSTAG ?= v0.97.0

.PHONY: build-tailscaled-container
build-tailscaled-container:
	docker build -f build/Dockerfile.build -t tailscale-qnap-builder:latest build/

out/tailscaled-amd64 out/tailscaled-386 out/tailscaled-arm out/tailscaled-arm64: build-tailscaled-container
	docker run --rm -v ${CURDIR}/out:/out -e TSTAG=${TSTAG} tailscale-qnap-builder
