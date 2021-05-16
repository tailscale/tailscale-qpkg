TSTAG ?= v1.8.1

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
	docker run --rm -v ${CURDIR}/out:/out -v ${CURDIR}/icons:/icons -e TSTAG=${TSTAG} qdk:latest

.PHONY: clean
clean:
	rm -rf out/pkg
	rm -f out/tailscaled-*
	rm -f out/tailscale-*
