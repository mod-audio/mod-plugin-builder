#!/bin/bash

source .common

rm -f  ${WORKDIR}/download/*
rm -rf ${WORKDIR}/plugins/*
rm -rf ${WORKDIR}/plugins-dep/build/*/*
rm -rf ${WORKDIR}/plugins-dep/build/*/._*
rm -rf ${WORKDIR}/plugins-dep/build/*/.hg*
rm -rf ${WORKDIR}/plugins-dep/build/*/.git*
rm -rf ${WORKDIR}/plugins-dep/build/*/.libs
rm -rf ${WORKDIR}/plugins-dep/build/*/.waf-*
rm -f  ${WORKDIR}/plugins-dep/images/rootfs.tar

rm -rf ${BUILD_DIR}/${CT_NG_VERSION}
mkdir ${BUILD_DIR}/${CT_NG_VERSION}
touch ${BUILD_DIR}/${CT_NG_VERSION}/.stamp_configured
touch ${BUILD_DIR}/${CT_NG_VERSION}/.stamp_built1
touch ${BUILD_DIR}/${CT_NG_VERSION}/.stamp_built2
touch ${BUILD_DIR}/${CT_NG_VERSION}/configure
