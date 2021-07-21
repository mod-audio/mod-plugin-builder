#!/bin/bash

set -e

#######################################################################################################################
# check arguments

PLATFORM="${1}"
DOCKER_IMAGE="${2}"

if [[ "${PLATFORM}" == "" ]] || [[ "${DOCKER_IMAGE}" == "" ]]; then
  echo "Usage: $0 <platform> <docker-image>"
  echo "  Where platform can be modduo, modduox, moddwarf or x86_64"
  exit 1
fi

#######################################################################################################################
# Import common code and variables

cd $(dirname ${0})
source .common

#######################################################################################################################
# Now setup docker mountpoints (or run it if already exists)

if docker ps -a | grep -q "mpb_${PLATFORM}"; then
  docker start -i "mpb_${PLATFORM}"
else
  docker run --name "mpb_${PLATFORM}" -ti -v $(pwd):/home/builder/mod-plugin-builder -v ${PLUGINS_DIR}:/home/builder/mod-workdir/${PLATFORM}/plugins "${DOCKER_IMAGE}"
fi
