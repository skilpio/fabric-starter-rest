#!/usr/bin/env bash

FABRIC_STARTER_VERSION=${1:-${FABRIC_STARTER_VERSION:-latest}}
FABRIC_STARTER_REPOSITORY=${2:-olegabu}
DOCKER_REGISTRY=${3:-docker.io}

EXTERNAL_ADMIN_WEBAPP_TGZ=${4:-${EXTERNAL_ADMIN_WEBAPP_TGZ}}
[ -n "${EXTERNAL_ADMIN_WEBAPP_TGZ}" ] && USE_EXTERNAL_ADMIN_WEBAPP=true

echo "Using custom admin webapp: ${EXTERNAL_ADMIN_WEBAPP_TGZ}."
pushd ..

#docker pull ${DOCKER_REGISTRY}/${FABRIC_STARTER_REPOSITORY}/fabric-starter-rest:${FABRIC_STARTER_VERSION}-base || true

docker build -t ${DOCKER_REGISTRY}/${FABRIC_STARTER_REPOSITORY}/fabric-starter-rest:${FABRIC_STARTER_VERSION}  \
  --build-arg="DOCKER_REGISTRY=${DOCKER_REGISTRY}" --build-arg="FABRIC_STARTER_VERSION=${FABRIC_STARTER_VERSION}" \
  --build-arg="FABRIC_STARTER_REPOSITORY=${FABRIC_STARTER_REPOSITORY}" \
  --build-arg="USE_EXTERNAL_ADMIN_WEBAPP=${USE_EXTERNAL_ADMIN_WEBAPP}" \
  --build-arg="EXTERNAL_ADMIN_WEBAPP_TGZ=${EXTERNAL_ADMIN_WEBAPP_TGZ}" \
  -f Dockerfile .  \
  --no-cache

popd