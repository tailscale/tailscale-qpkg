TRACK ?= stable
# QNAP has a upper limit of 10 characters for the version.
# For unstable builds we might have 1.X.YYYY-Z
TSTAG ?= 1.12.1
QNAPTAG ?= 1

.PHONY: fetch
fetch:
	TSTAG=${TSTAG} TRACK=${TRACK} ./build/fetch.sh

.PHONY: build-qdk-container
build-qdk-container:
	docker build -f build/Dockerfile.qpkg -t build.tailscale.io/qdk:latest build/

.PHONY: pkg
pkg: fetch
	docker run --rm \
		-e TSTAG=${TSTAG} \
		-e QNAPTAG=${QNAPTAG} \
		-v ${CURDIR}/out/tailscale-${TSTAG}:/out \
		-v ${CURDIR}/Tailscale:/Tailscale \
		-v ${CURDIR}/build/build-qpkg.sh:/build-qpkg.sh \
		build.tailscale.io/qdk:latest \
		/build-qpkg.sh

.PHONY: clean
clean:
	rm -rf out/pkg
