#!/usr/bin/env bash

set -eu

VARIANTS=("manylinux2014_x86_64" "manylinux2014_i686" "manylinux2014_aarch64" "manylinux2014_ppc64le" "manylinux2014_s390x")
TARGET_REGISTRY="lukewiwa"
MANIFEST_ARGS=()

for VARIANT in "${VARIANTS[@]}";
do
  echo "processing variant $VARIANT"
  docker pull "quay.io/pypa/$VARIANT"
  docker image tag "quay.io/pypa/$VARIANT" "$TARGET_REGISTRY/$VARIANT:latest"
  docker image push "$TARGET_REGISTRY/$VARIANT:latest"
  MANIFEST_ARGS+=("--amend")
  MANIFEST_ARGS+=("$TARGET_REGISTRY/$VARIANT")
  echo "done variant $VARIANT"
done

echo "creating manifest pointing to architectural variants"
docker manifest create lukewiwa/manylinux2014:latest "${MANIFEST_ARGS[@]}"

echo "pushing multiarch manifest to registry"
docker manifest push lukewiwa/manylinux2014:latest
