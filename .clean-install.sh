#!/bin/bash

cd $(dirname ${0})

#######################################################################################################################
# check arguments

PLATFORM=$1

if [ -z "${PLATFORM}" ] || [ ! -e "plugins-dep/configs/${PLATFORM}_defconfig" ]; then
  echo "Usage: $0 <platform>"
  echo "  Where platform can be one of: $(echo $(ls plugins-dep/configs | grep _defconfig | sed 's/_defconfig//g' | sort))"
  exit 1
fi

#######################################################################################################################
# Import common code and variables

source .common

#######################################################################################################################
# cleanup

mv ${BUILD_DIR}/${BUILDROOT_VERSION} ${WORKDIR}/${PLATFORM}/${BUILDROOT_VERSION}

rm -rf ${BUILD_DIR}/*/*
rm -rf ${BUILD_DIR}/*/._*
rm -rf ${BUILD_DIR}/*/.hg*
rm -rf ${BUILD_DIR}/*/.git*
rm -rf ${BUILD_DIR}/*/.libs
rm -rf ${BUILD_DIR}/*/.waf-*
rm -rf ${DOWNLOAD_DIR}/*
rm -rf ${WORKDIR}/${PLATFORM}/images/*

mv ${WORKDIR}/${PLATFORM}/${BUILDROOT_VERSION} ${BUILD_DIR}/${BUILDROOT_VERSION}

rm -rf ${BUILD_DIR}/${CT_NG_VERSION}
mkdir ${BUILD_DIR}/${CT_NG_VERSION}
touch ${BUILD_DIR}/${CT_NG_VERSION}/.stamp_configured
touch ${BUILD_DIR}/${CT_NG_VERSION}/.stamp_built1
touch ${BUILD_DIR}/${CT_NG_VERSION}/.stamp_built2
touch ${BUILD_DIR}/${CT_NG_VERSION}/.stamp_patched
touch ${BUILD_DIR}/${CT_NG_VERSION}/configure

# fix various autoconf-related dependency_libs
sed -i -e "s|${BUILD_DIR}/libglib2-2.46.2/gobject/|${WORKDIR}/${PLATFORM}/staging/usr/lib/|g" ${WORKDIR}/${PLATFORM}/staging/usr/lib/*.la
sed -i -e "s|${BUILD_DIR}/libglib2-2.46.2/gmodule/|${WORKDIR}/${PLATFORM}/staging/usr/lib/|g" ${WORKDIR}/${PLATFORM}/staging/usr/lib/*.la
sed -i -e "s|${BUILD_DIR}/libglib2-2.46.2/glib/|${WORKDIR}/${PLATFORM}/staging/usr/lib/|g" ${WORKDIR}/${PLATFORM}/staging/usr/lib/*.la
sed -i -e "s|${BUILD_DIR}/libvorbis-1.3.5/lib/|${WORKDIR}/${PLATFORM}/staging/usr/lib/|g" ${WORKDIR}/${PLATFORM}/staging/usr/lib/*.la
sed -i -e "s|${BUILD_DIR}/util-linux-2.27.1/|${WORKDIR}/${PLATFORM}/staging/usr/lib/|g" ${WORKDIR}/${PLATFORM}/staging/usr/lib/*.la

#######################################################################################################################
