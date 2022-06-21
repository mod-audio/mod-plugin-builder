#!/bin/bash

set -e

cd $(dirname ${0})

#######################################################################################################################
# check arguments

PLATFORM="${1}"
DOCKER_IMAGE="${2}"

if [ -z "${PLATFORM}" ] || [ -z "${DOCKER_IMAGE}" ] || [ ! -e "plugins-dep/configs/${PLATFORM}_defconfig" ]; then
  echo "Usage: $0 <platform> <docker-image>"
  echo "  Where platform can be one of: $(echo $(ls plugins-dep/configs | grep _defconfig | sed 's/_defconfig//g' | sort))"
  exit 1
fi

#######################################################################################################################
# Import common code and variables

source .common

#######################################################################################################################
# Now setup docker mountpoints (or run it if already exists)

if docker ps -a | grep -q "mpb_${PLATFORM}"; then
  docker start -i "mpb_${PLATFORM}"
else
  docker run --name "mpb_${PLATFORM}" -ti -v $(pwd):/home/builder/mod-plugin-builder -v ${PLUGINS_DIR}:/home/builder/mod-workdir/${PLATFORM}/plugins "${DOCKER_IMAGE}"
fi
