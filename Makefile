.PHONY: build-tailscaled-container
build-tailscaled-container:
	docker build -f build/Dockerfile.build -t tailscale-qnap-builder:latest build/

out/tailscale: build-tailscaled-container
	docker run --rm -v ${CURDIR}/out:/out -v ${CURDIR}/vendor:/go/src tailscale-qnap-builder
