#!/usr/bin/env bash
set -euo pipefail
BUILD_DIR="./kilt-build-work/build/libs"
RELEASE_DIR="./kilt-release"
mkdir -p "$RELEASE_DIR"
cp "$BUILD_DIR"/*.jar "$RELEASE_DIR"/ || true
# include README and license
cp README.txt "$RELEASE_DIR"/ || true
echo "Release assembled in $RELEASE_DIR"
