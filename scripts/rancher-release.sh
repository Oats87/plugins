#!/bin/sh
set -xe

TAG=$(git describe --tags --dirty)

RELEASE_DIR=release
OUTPUT_DIR=bin

rm -rf ${RELEASE_DIR}
mkdir -p ${RELEASE_DIR}
mkdir -p ${OUTPUT_DIR}

for arch in amd64 arm arm64; do
    rm -f ${OUTPUT_DIR}/*;
    CGO_ENABLED=0 GOARCH=$arch ./build_linux.sh -ldflags "-extldflags -static -X github.com/containernetworking/plugins/pkg/utils/buildversion.BuildVersion=${TAG}";
    cp ${OUTPUT_DIR}/portmap ${RELEASE_DIR}/portmap-${arch}
done;
