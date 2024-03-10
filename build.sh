#!/bin/bash
v="3.19.1"
rv="1.76.0"
tag="main"
# shellcheck disable=SC2068
#docker  build \
#  --build-arg BASE_VERSION="${v}" \
#  --platform linux/amd64 \
#  --cache-from ghcr.io/calm04061/account:cache-amd64 \
#  --cache-to type=registry,ref=ghcr.io/calm04061/account:cache-amd64,mode=max \
#  -t ghcr.io/calm04061/account:"${tag}"-amd64 \
#  --provenance=false --sbom=false --push  .
docker buildx build \
  --build-arg BASE_VERSION="${v}" \
  --build-arg RUST_VERSION="${rv}" \
  --platform linux/amd64 \
  --cache-from ghcr.io/calm04061/github-cache:cache-amd64 \
  --cache-to type=registry,ref=ghcr.io/calm04061/github-cache:cache-amd64,mode=max \
  -t ghcr.io/calm04061/github-cache:"${tag}"-amd64 \
  --provenance=false --sbom=false --push  .

#docker manifest create -a ghcr.io/calm04061/account:"${tag}" \
#  ghcr.io/calm04061/account:"${tag}"-amd64 \
#  ghcr.io/calm04061/account:"${tag}"-aarh64
#docker manifest push ghcr.io/calm04061/account:"${tag}" --purge