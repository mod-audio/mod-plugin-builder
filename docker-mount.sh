#!/bin/bash

set -e

cd $(dirname ${0})

#######################################################################################################################
# check arguments

PLATFORM="${1}"
EXTRA_MOUNT_PATH="${2}"

if [ -z "${PLATFORM}" ] || [ ! -e "plugins-dep/configs/${PLATFORM}_defconfig" ]; then
  echo "Usage: $0 <platform> <extra-mount-path>"
  echo "  Where platform can be one of: $(echo $(ls plugins-dep/configs | grep _defconfig | sed 's/_defconfig//g' | sort))"
  exit 1
fi

#######################################################################################################################
# Import common code and variables

source .common

#######################################################################################################################
# Build docker image first if needed

if ! docker images | grep -q "^mpbi_${PLATFORM} "; then
  docker buildx build \
    --build-arg platform="${PLATFORM}" \
    --build-arg target=toolchain \
    --tag "mpbi_${PLATFORM}" \
    "$(pwd)/docker"
fi

#######################################################################################################################
# Now setup docker mountpoints (or run it if already exists)

if docker ps -a | grep -q "^mpb_${PLATFORM} "; then
  docker start -i "mpb_${PLATFORM}"
elif [ -n "${EXTRA_MOUNT_PATH}" ]; then
  docker run --name "mpb_${PLATFORM}" -ti \
    -v "$(pwd)":"/home/builder/mod-plugin-builder" \
    -v "${EXTRA_MOUNT_PATH}":"/mnt" \
    "mpbi_${PLATFORM}"
else
  docker run --name "mpb_${PLATFORM}" -ti \
    -v "$(pwd)":"/home/builder/mod-plugin-builder" \
    -v "${PLUGINS_DIR}":"/home/builder/mod-workdir/${PLATFORM}/plugins" \
    "mpbi_${PLATFORM}"
fi
